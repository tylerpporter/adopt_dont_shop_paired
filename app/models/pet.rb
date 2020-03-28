class Pet < ApplicationRecord
  validates_presence_of :image,
                        :name,
                        :approx_age,
                        :sex,
                        :status,
                        :description,
                        :shelter_id
  belongs_to :shelter
  has_many :pet_apps
  has_many :apps, through: :pet_apps
  default_scope { order(status: :asc) }
end
