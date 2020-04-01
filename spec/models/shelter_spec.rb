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
    it "can return the average rating for that shelter" do
      shelter1 = Shelter.create(name: "Pallet Town Shelter",
                          address: "Route 1",
                          city:  "Pallet Town",
                          state: "Kanto",
                          zip: "80807")
      review1 = ShelterReview.create!(title: "This place is great!",
                              rating: 5,
                              content: "This shelter treats all of its Pokemon (and customers!) with immense care!",
                              picture: "https://img.pokemondb.net/artwork/large/caterpie.jpg",
                              shelter_id: shelter1.id)
      review2 = ShelterReview.create!(title: "This place is ok!",
                              rating: 3,
                              content: "This shelter treats all of its Pokemon (and customers!) with immense care!",
                              picture: "https://img.pokemondb.net/artwork/large/caterpie.jpg",
                              shelter_id: shelter1.id)
      shelter2 = Shelter.create(name: "Cerulean City Center",
                          address: "Route 5",
                          city:  "Cerulean City",
                          state: "Kanto",
                          zip: "80808")

      expect(shelter1.average_rating).to eq(4.0)
      expect(shelter2.average_rating).to eq(1.0)
    end
    it "can return number of applications on file for that shelter" do
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
      app1 = App.create(name: "Misty",
                        address: "123 Staryu St.",
                        city: "Cerulean City",
                        state: "Kanto",
                        zip: "80005",
                        phone_number: "555-555-1234",
                        description: "I am a compassionate and caring water pokemon trainer!",
                        pets: [pet1])
      app2 = App.create(name: "Brock",
                        address: "123 Onyx St.",
                        city: "Pewter City",
                        state: "Kanto",
                        zip: "80006",
                        phone_number: "444-444-1234",
                        description: "I'm a certified gym leader",
                        pets: [pet1])

      expect(shelter1.app_count).to eq(2)
    end
  describe "class methods"
    it "top_3" do
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
      shelter3 = Shelter.create(name: "Safari Zone Rescue",
                          address: "Route 48",
                          city:  "Fuchsia City",
                          state: "Kanto",
                          zip: "80809")
      shelter4 = Shelter.create(name: "Who Cares",
                          address: "Route 48",
                          city:  "Fuchsia City",
                          state: "Kanto",
                          zip: "80809")
      review1 = ShelterReview.create!(title: "This place is great!",
                              rating: 4,
                              content: "This shelter treats all of its Pokemon (and customers!) with immense care!",
                              picture: "https://img.pokemondb.net/artwork/large/caterpie.jpg",
                              shelter_id: shelter1.id)
      review2 = ShelterReview.create!(title: "This place is ok!",
                              rating: 5,
                              content: "This shelter treats all of its Pokemon (and customers!) with immense care!",
                              picture: "https://img.pokemondb.net/artwork/large/caterpie.jpg",
                              shelter_id: shelter2.id)
      review3 = ShelterReview.create!(title: "This place is fine!",
                              rating: 1,
                              content: "This shelter treats all of its Pokemon (and customers!) with immense care!",
                              picture: "https://img.pokemondb.net/artwork/large/caterpie.jpg",
                              shelter_id: shelter3.id)
      review4 = ShelterReview.create!(title: "This place is alright!",
                              rating: 3,
                              content: "This shelter treats all of its Pokemon (and customers!) with immense care!",
                              picture: "https://img.pokemondb.net/artwork/large/caterpie.jpg",
                              shelter_id: shelter4.id)
      expect(Shelter.top_3).to eq([shelter2, shelter1, shelter4])
    end
end
