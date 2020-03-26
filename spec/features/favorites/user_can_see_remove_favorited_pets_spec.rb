# When I click on that button or link to remove a favorite
# A delete request is sent to "/favorites/:pet_id"
# And I'm redirected back to the favorites page where I no longer see that pet listed
# And I also see that the favorites indicator has decremented by 1

require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "when I visit /favorites"
    it "each to next pet, I see link to remove that pet from my favorites, which removes a favorited pet" do
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
      find("#favorite-#{pet_1.id}").click


      visit "/pets/#{pet_2.id}"
      find("#favorite-#{pet_2.id}").click

      visit "/favorites"

      within("nav") do
        expect(page).to have_content("Favorites (2)")
      end

      expect(page).to have_content("Pidgey")
      expect(page).to have_css("#favorite-#{pet_1.id}")
      expect(page).to have_content("Weedle")
      expect(page).to have_css("#favorite-#{pet_2.id}")

      find("#favorite-#{pet_1.id}").click

      expect(current_path).to eq("/favorites")

      within("nav") do
        expect(page).to have_content("Favorites (1)")
      end

      within(".notice") do
        expect(page).to have_content("Pidgey has been removed from favorites")
      end

      within(".all-pets") do
        expect(page).to have_no_content("Pidgey")
        expect(page).to have_no_css("#favorite-#{pet_1.id}")
        expect(page).to have_content("Weedle")
        expect(page).to have_css("#favorite-#{pet_2.id}")
      end

  end
end
