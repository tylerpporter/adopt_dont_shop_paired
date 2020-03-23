class Pet < ApplicationRecord
  validates_presence_of :image, :name, :approx_age, :sex, :status, :description, :shelter_id
  belongs_to :shelter
  default_scope { order(status: :asc) }
end