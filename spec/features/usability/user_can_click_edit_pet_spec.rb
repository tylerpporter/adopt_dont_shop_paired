require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "when I visit the pets index or shelters pet index page"
    it "I can see a link to edit pet info, which takes me to edit pet form" do
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
      visit "/pets"

      click_link "Edit"

      expect(page).to have_current_path("/pets/#{pet_1.id}/edit")

      expect(page).to have_field("image")
      expect(page).to have_field("name")
      expect(page).to have_field("description")
      expect(page).to have_field("approx_age")
      expect(page).to have_field("sex")

      visit "/shelters/#{shelter_1.id}/pets"

      click_link "Edit"

      expect(page).to have_current_path("/pets/#{pet_1.id}/edit")

      expect(page).to have_field("image")
      expect(page).to have_field("name")
      expect(page).to have_field("description")
      expect(page).to have_field("approx_age")
      expect(page).to have_field("sex")
  end
end
