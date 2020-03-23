require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "when I visit any page"
    it "I can get back to pets index page" do
      visit "/"

      click_link "Pets"

      expect(page).to have_current_path("/pets")

      visit "/shelters"

      click_link "Pets"

      expect(page).to have_current_path("/pets")
    end
    it "I can get back to shelters index page" do
      visit "/"

      click_link "Shelters"

      expect(page).to have_current_path("/shelters")

      visit "/shelters"

      click_link "Shelters"

      expect(page).to have_current_path("/shelters")
    end
end

