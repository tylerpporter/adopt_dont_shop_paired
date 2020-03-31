require 'rails_helper'

# User Story 31, Pets with approved applications cannot be deleted
RSpec.describe "As a visitor" do
  describe "If a pet has an approved application on them"
    it "I can not delete that pet" do
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
      app_1 = App.create(name: "Misty",
                        address: "123 Staryu St.",
                        city: "Cerulean City",
                        state: "Kanto",
                        zip: "80005",
                        phone_number: "555-555-1234",
                        description: "I am a compassionate and caring water pokemon trainer!")

      visit "/pets/#{pet_1.id}"
      find("#favorite-#{pet_1.id}").click

      app_1.pets << pet_1

      visit "/apps/#{app_1.id}"
      within("#pet-#{pet_1.id}") do
        click_link "Approve Application"
      end

      visit "/pets/#{pet_1.id}"
      click_link "Delete"

      expect(page).to have_content("Pet cannot be deleted")

    end
end