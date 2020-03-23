require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "when I visit a shelter show page"
    it "I can click a link to delete shelter, which deletes a shelter" do
      shelter_1 = Shelter.create(name: "Pallet Town Shelter",
                          address: "Route 1",
                          city:  "Pallet Town",
                          state: "Kanto",
                          zip: "80807")
      shelter_2 = Shelter.create(name: "Cerulean City Center",
                          address: "Route 5",
                          city:  "Cerulean City",
                          state: "Kanto",
                          zip: "80808")

      visit "/shelters/#{shelter_1.id}"

      expect(page).to have_content(shelter_1.name)

      click_link "Delete Shelter"

      expect(page).to have_current_path("/shelters")
      expect(page).to have_no_content(shelter_1.name)
      expect(page).to have_content(shelter_2.name)
      expect(Shelter.count).to eq(1)
    end
end
