require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "when I visit the shelter index age"
    it "I can see a link to delete shelter and clicking on it delete shelter" do
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

      visit "/shelters/"

      expect(page).to have_content(shelter_1.name)
      expect(page).to have_content(shelter_2.name)

      find("#shelter-#{shelter_1.id}").click

      expect(page).to have_current_path("/shelters")
      expect(page).to have_no_content(shelter_1.name)
      expect(page).to have_content(shelter_2.name)
      expect(Shelter.count).to eq(1)
  end
end