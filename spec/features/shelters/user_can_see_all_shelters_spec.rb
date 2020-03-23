require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "when I visit /shelters"
    it "I can see all shelters" do
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
      shelter_3 = Shelter.create(name: "Safari Zone Rescue",
                          address: "Route 48",
                          city:  "Fuchsia City",
                          state: "Kanto",
                          zip: "80809")
      visit "/shelters"

      expect(page).to have_content(shelter_1.name)
      expect(page).to have_content(shelter_2.name)
      expect(page).to have_content(shelter_3.name)
  end

  describe "when I visit /shelters/:id"
    it "can see all shelter information" do
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
      expect(page).to have_content("Address: #{shelter_1.address}")
      expect(page).to have_content("City: #{shelter_1.city}")
      expect(page).to have_content("State: #{shelter_1.state}")
      expect(page).to have_content("Zip: #{shelter_1.zip}")

      visit "/shelters/#{shelter_2.id}"

      expect(page).to have_content(shelter_2.name)
      expect(page).to have_content("Address: #{shelter_2.address}")
      expect(page).to have_content("City: #{shelter_2.city}")
      expect(page).to have_content("State: #{shelter_2.state}")
      expect(page).to have_content("Zip: #{shelter_2.zip}")
  end
end

