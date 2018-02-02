class Version < ApplicationRecord
  # Associations
  belongs_to :package

  # Validations
  validates :name, presence: true, uniqueness: true
  validates :published_at, presence: true
end
