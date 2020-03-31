require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'validations' do
    it {should validate_presence_of :image}
    it {should validate_presence_of :name}
    it {should validate_presence_of :approx_age}
    it {should validate_presence_of :sex}
    it {should validate_presence_of :description}
    it {should validate_presence_of :status}
    it {should validate_presence_of :shelter_id}
  end

  describe 'relationships' do
    it {should belong_to :shelter}
    it {should have_many :pet_apps}
    it {should have_many(:apps).through(:pet_apps)}
  end

  describe 'default scope'
    it 'orders by ascending name' do
      shelter_1 = Shelter.create(name: "Pallet Town Shelter",
                          address: "Route 1",
                          city:  "Pallet Town",
                          state: "Kanto",
                          zip: "80807")
      pet_1 = Pet.create(image: "https://img.pokemondb.net/artwork/large/pidgey.jpg",
                          name: "Pidgey",
                          description: "Very gentle and loving",
                          approx_age:  4,
                          sex: "Male",
                          status: "Pending",
                          shelter_id: shelter_1.id)
      pet_2 = Pet.create(image: "https://img.pokemondb.net/artwork/large/pidgey.jpg",
                          name: "Weedle",
                          description: "Weed is a loyal and affectionate friend.",
                          approx_age:  2,
                          sex: "Male",
                          status: "Adoptable",
                          shelter_id: shelter_1.id)
      expect(Pet.all).to eq [pet_2, pet_1]
    end

  describe "instance methods"
    it "method approved_applicant" do
      shelter_1 = Shelter.create(name: "Pallet Town Shelter",
                          address: "Route 1",
                          city:  "Pallet Town",
                          state: "Kanto",
                          zip: "80807")
      pet_1 = Pet.create(image: "https://img.pokemondb.net/artwork/large/pidgey.jpg",
                          name: "Pidgey",
                          description: "Very gentle and loving",
                          approx_age:  4,
                          sex: "Male",
                          status: "Pending",
                          shelter_id: shelter_1.id)
      app_1 = App.create(name: "Misty",
                        address: "123 Staryu St.",
                        city: "Cerulean City",
                        state: "Kanto",
                        zip: "80005",
                        phone_number: "555-555-1234",
                        description: "I am a compassionate and caring water pokemon trainer!")

      favorite = Favorite.new(Array.new)
      favorite.add_pet(pet_1.id)
      app_1.pets << pet_1
      pet_1.update(status: "Pending", notes: "On hold for #{app_1.name}")

      expect(pet_1.approved_applicant).to eq app_1.id

    end

end
