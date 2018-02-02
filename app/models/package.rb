class Package < ApplicationRecord
  # Associations
  has_many :versions, dependent: :delete_all
  has_many :authors_packages, dependent: :delete_all
  has_many :maintainers_packages, dependent: :delete_all
  has_many :authors, through: :authors_packages, source: :person
  has_many :maintainers, through: :maintainers_packages, source: :person

  # Validations
  validates :name, presence: true, uniqueness: true

  # Methods
  def self.register(package_info)
    ActiveRecord::Base.transaction do
      # Find or create the Package
      package = Package.find_or_initialize_by(name: package_info[:name])
      package.title = package_info[:title]
      package.description = package_info[:description]
      package.save!

      # Find or create Author and Maintainer
      authors =
        package_info[:authors].map do |author_info|
          person = Person.find_or_initialize_by(name: author_info[:name])
          person.email = author_info[:email]
          person.save!
          person
        end

      maintainers =
        package_info[:maintainers].map do |maintainer_info|
          person = Person.find_or_initialize_by(name: maintainer_info[:name])
          person.email = maintainer_info[:email]
          person.save!
          person
        end

      # Associate Package-Author and Package-Maintainer
      authors.each do |author|
        package.authors_packages.find_or_create_by!(person: author)
      end

      maintainers.each do |maintainer|
        package.maintainers_packages.find_or_create_by!(person: maintainer)
      end

      # Find or create the Version
      version = package.versions.find_or_initialize_by(name: package_info[:name])
      version.published_at = package_info[:publication]
      version.save!

      # Done
      package
    end
  end
end
