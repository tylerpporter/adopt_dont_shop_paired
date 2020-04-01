class ShelterReview < ApplicationRecord
  after_initialize :set_defaults
  validates_presence_of :title,
                        :rating,
                        :content,
                        :shelter_id
  belongs_to :shelter

  def set_defaults
    self.picture = "site/pokeball.png" if self.picture == ""
  end

end
