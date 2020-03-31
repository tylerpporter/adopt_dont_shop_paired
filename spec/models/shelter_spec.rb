require 'rails_helper'

RSpec.describe Shelter, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
  end

  describe 'relationships' do
    it {should have_many :pets}
  end

  describe 'instance methods'
    it 'knows if it has any pets with approved apps' do
      shelter1 = Shelter.create(name: "Pallet Town Shelter",
                          address: "Route 1",
                          city:  "Pallet Town",
                          state: "Kanto",
                          zip: "80807")
      shelter2 = Shelter.create(name: "Cerulean City Center",
                          address: "Route 5",
                          city:  "Cerulean City",
                          state: "Kanto",
                          zip: "80808")
      pet1 = Pet.create(image: "https://img.pokemondb.net/artwork/large/pidgey.jpg",
                        name: "Pidgey",
                        description: "Very gentle and loving",
                        approx_age:  4,
                        sex: "Male",
                        status: "Pending",
                        shelter_id: shelter1.id)
      pet2 = Pet.create(image: "https://img.pokemondb.net/artwork/large/weedle.jpg",
                          name: "Weedle",
                          description: "Weed is a loyal and affectionate friend.",
                          approx_age:  2,
                          sex: "Male",
                          status: "Adoptable",
                          shelter_id: shelter2.id)

      expect(shelter1.approved_apps?).to be true
      expect(shelter2.approved_apps?).to be false
    end
    it "can return number of pets at that shelter" do
      shelter1 = Shelter.create(name: "Pallet Town Shelter",
                          address: "Route 1",
                          city:  "Pallet Town",
                          state: "Kanto",
                          zip: "80807")
      pet1 = Pet.create(image: "https://img.pokemondb.net/artwork/large/pidgey.jpg",
                        name: "Pidgey",
                        description: "Very gentle and loving",
                        approx_age:  4,
                        sex: "Male",
                        status: "Pending",
                        shelter_id: shelter1.id)
      pet2 = Pet.create(image: "https://img.pokemondb.net/artwork/large/weedle.jpg",
                          name: "Weedle",
                          description: "Weed is a loyal and affectionate friend.",
                          approx_age:  2,
                          sex: "Male",
                          status: "Adoptable",
                          shelter_id: shelter1.id)
      expect(shelter1.pet_count).to eq(2)
    end
end
