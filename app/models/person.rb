class Person < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :email }
  validates :email, uniqueness: { case_sensitive: false }, allow_blank: true

  # Associations
  has_many :authors_packages, dependent: :delete_all
  has_many :maintainers_packages, dependent: :delete_all
  has_many :created_packages, through: :authors_packages, source: :package
  has_many :maintained_packages, through: :maintainers_packages, source: :package
end
