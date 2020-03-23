require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "when I visit the shelter index age"
    it "I can see a link to edit shelter info and clicking on it takes me to edit form" do
      shelter_1 = Shelter.create(name: "Pallet Town Shelter",
                          address: "Route 1",
                          city:  "Pallet Town",
                          state: "Kanto",
                          zip: "80807")
      visit "/shelters"

      click_link "Edit"

      expect(page).to have_current_path("/shelters/#{shelter_1.id}/edit")

      expect(page).to have_field("name", :with => "#{shelter_1.name}")
      expect(page).to have_field("address", :with => "#{shelter_1.address}")
      expect(page).to have_field("city", :with => "#{shelter_1.city}")
      expect(page).to have_field("state", :with => "#{shelter_1.state}")
      expect(page).to have_field("zip", :with => "#{shelter_1.zip}")
  end
end