require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "when I visit a shelter index page"
    it "I should see a link to sort shelters alphabetical" do
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
      shelter_3 = Shelter.create(name: "Z Shelter",
                          address: "Route 55",
                          city:  "Z City",
                          state: "Kanto",
                          zip: "80810")
      visit "/shelters"

      click_link "Sort Shelters Alphabetically"

      within '.info' do
        expect(page.all('.shelter')[0]).to have_content("#{shelter_2.name}")
        expect(page.all('.shelter')[1]).to have_content("#{shelter_1.name}")
        expect(page.all('.shelter')[2]).to have_content("#{shelter_3.name}")
      end
    end
end