
require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "when I visit a pet show page"
    it "I should see a link to change pet's status" do
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
                          status: "Adoptable",
                          shelter_id: shelter_1.id)
      pet_2 = Pet.create(image: "https://img.pokemondb.net/artwork/large/weedle.jpg",
                          name: "Weedle",
                          description: "Weed is a loyal and affectionate friend.",
                          approx_age:  2,
                          sex: "Male",
                          status: "Pending",
                          shelter_id: shelter_1.id)

      visit "pets/#{pet_1.id}"

      expect(page).to have_content("Adoptable")
      click_link "Change to Adoption Pending"
      expect(current_path).to eq("/pets/#{pet_1.id}")
      expect(page).to have_content("Pending")

      visit "/pets/#{pet_2.id}"
      expect(page).to have_content("Pending")
      click_link "Change to Adoptable"
      expect(current_path).to eq("/pets/#{pet_2.id}")
      expect(page).to have_content("Adoptable")
    end
end