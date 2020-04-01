class Shelter < ApplicationRecord
  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip
  has_many :pets, dependent: :destroy
  has_many :shelter_reviews, dependent: :destroy

  def self.top_3
    all.sort_by(&:average_rating).reverse.slice(0..2)
  end

  def approved_apps?
    pets.any? {|pet| pet.status == "Pending"}
  end

  def pet_count
    pets.size
  end

  def average_rating
    return 1 if shelter_reviews.average(:rating).nil?
    shelter_reviews.average(:rating)
  end

  def app_count
    pets.sum(&:app_count)
  end

end
