require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "when I visit a shelter show page"
    it "I can click a link to update shelter, which takes me to an edit shelter form" do
      shelter_1 = Shelter.create(name: "Pallet Town Shelter",
                          address: "Route 1",
                          city:  "Pallet Town",
                          state: "Kanto",
                          zip: "80807")

      visit "/shelters/#{shelter_1.id}"

      click_link "Update Shelter"

      expect(current_path).to eq("/shelters/#{shelter_1.id}/edit")

      fill_in('name', :with => "Pallet Town Poke Home")
      fill_in('address', :with => "Route 22")
      fill_in('city', :with => "Eterna City")
      fill_in('state', :with => "Sinnoh")
      fill_in('zip', :with => "80899")

      click_button "Update Shelter"

      expect(page).to have_current_path("/shelters/#{shelter_1.id}")
      expect(page).to have_content("Pallet Town Poke Home")
    end
end