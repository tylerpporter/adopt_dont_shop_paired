require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "when I visit the shelter index age"
    it "I can click a shelter link and see shelter show page" do
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

      visit "/shelters"

      within ".highest-rated" do
        click_link "#{shelter_1.name}"
      end

      expect(page).to have_current_path("/shelters/#{shelter_1.id}")
      expect(page).to have_content(shelter_1.name)

      visit "/shelters"

      within ".shelter" do
        click_link "#{shelter_1.name}"
      end

      expect(page).to have_current_path("/shelters/#{shelter_1.id}")
      expect(page).to have_content(shelter_1.name)

      visit "/pets"

      click_link "#{shelter_1.name}"
      expect(page).to have_current_path("/shelters/#{shelter_1.id}")
      expect(page).to have_content(shelter_1.name)

  end
end
