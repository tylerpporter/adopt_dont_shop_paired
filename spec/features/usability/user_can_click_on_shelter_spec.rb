require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "when I visit the shelter index age"
    it "I can click a shelter link and see shelter show page" do
      shelter_1 = Shelter.create(name: "Pallet Town Shelter",
                          address: "Route 1",
                          city:  "Pallet Town",
                          state: "Kanto",
                          zip: "80807")
      visit "/shelters"

      click_link "#{shelter_1.name}"

      expect(page).to have_current_path("/shelters/#{shelter_1.id}")

      expect(page).to have_content(shelter_1.name)
      expect(page).to have_content(shelter_1.address)
      expect(page).to have_content(shelter_1.city)
      expect(page).to have_content(shelter_1.state)
      expect(page).to have_content(shelter_1.zip)
  end
end