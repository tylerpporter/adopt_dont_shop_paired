require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "when I visit the shelter show page"
    it "I can click a link to see all pets in shelter" do
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

      visit "/shelters/#{shelter_1.id}"

      click_link "View Pets"

      expect(page).to have_current_path("/shelters/#{shelter_1.id}/pets")

      expect(page).to have_css("img[src*=pidgey]")
      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(pet_1.approx_age)
      expect(page).to have_content(pet_1.sex)
  end
end
