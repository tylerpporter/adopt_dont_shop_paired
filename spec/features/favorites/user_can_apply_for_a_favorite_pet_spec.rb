require 'rails_helper'

RSpec.describe 'as a visitor' do
  before :each do
    @shelter1 = Shelter.create!(name: "Pallet Town Shelter",
                        address: "Route 1",
                        city:  "Pallet Town",
                        state: "Kanto",
                        zip: "80807")
    @pet1 = Pet.create(image: "https://img.pokemondb.net/artwork/large/pidgey.jpg",
                      name: "Pidgey",
                      description: "Very gentle and loving",
                      approx_age:  4,
                      sex: "Male",
                      status: "Adoptable",
                      shelter_id: @shelter1.id)
    @pet2 = Pet.create(image: "https://img.pokemondb.net/artwork/large/weedle.jpg",
                      name: "Weedle",
                      description: "Weed is a loyal and affectionate friend.",
                      approx_age:  2,
                      sex: "Male",
                      status: "Pending",
                      shelter_id: @shelter1.id)
    visit "/pets/#{@pet1.id}"
    find("#favorite-#{@pet1.id}").click
    visit "/favorites"
  end
  describe 'when I visit /favorites'
    it 'I see a link for adopting my favorited pets' do

      click_link "Adopt a Pet"

      expect(current_path).to eq("/apps/new")
    end
end
