class AuthorsPackage < ApplicationRecord
  # Associations
  belongs_to :person
  belongs_to :package

  # Validations
  validates :person_id, uniqueness: { scope: :package_id }
end
