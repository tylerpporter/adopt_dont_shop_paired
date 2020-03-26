require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "when I visit /pets/:id"
    it "I can see a link to favorite a pet" do
      shelter_1 = Shelter.create!(name: "Pallet Town Shelter",
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

      visit "/pets/#{pet_1.id}"

      within("nav") do
        expect(page).to have_content("Favorites")
      end
      find("#favorite-#{pet_1.id}").click

      expect(current_path).to eq("/pets/#{pet_1.id}")

      expect(page).to have_content("#{pet_1.name} has been added to favorites")

      within("nav") do
        expect(page).to have_content("Favorites (1)")
      end

      visit "/pets/#{pet_2.id}"

      find("#favorite-#{pet_2.id}").click

      expect(current_path).to eq("/pets/#{pet_2.id}")

      expect(page).to have_content("#{pet_2.name} has been added to favorites")

      within("nav") do
        expect(page).to have_content("Favorites (2)")
      end

      find("#favorite-#{pet_2.id}").click

      within("nav") do
        expect(page).to have_content("Favorites (2)")
      end
  end
end
