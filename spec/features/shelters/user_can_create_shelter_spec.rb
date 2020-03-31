require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "when I visit the shelter index page"
    it "I can click a link to create shelter which takes me to a create shelter form" do
      visit "/shelters"

      click_link "New Shelter"

      expect(page).to have_current_path("/shelters/new")

      fill_in('name', :with => "Lavender Town Rescue")
      fill_in('address', :with => "Route 66")
      fill_in('city', :with => "Lavender Town")
      fill_in('state', :with => "Kanto")
      fill_in('zip', :with => "80810")

      click_button('Create Shelter')

      expect(page).to have_current_path("/shelters")
      expect(page).to have_content("Lavender Town Rescue")
    end
    it "I get an error message if I fails to fill out all fields" do
      visit "/shelters"

      click_link "New Shelter"

      fill_in('name', :with => "Lavender Town Rescue")
      fill_in('address', :with => "")
      fill_in('city', :with => "Lavender Town")
      fill_in('state', :with => "Kanto")
      fill_in('zip', :with => "80810")

      click_button('Create Shelter')

      expect(page).to have_content("Please fill out the following fields: Address")
    end
end
