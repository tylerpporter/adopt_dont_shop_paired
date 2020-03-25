RSpec.describe ShelterReview, type: :model do
  describe 'validations' do
    it {should validate_presence_of :title}
    it {should validate_presence_of :rating}
    it {should validate_presence_of :content}
    it {should validate_presence_of :shelter_id}
  end

  describe 'relationships' do
    it {should belong_to :shelter}
  end
end 
