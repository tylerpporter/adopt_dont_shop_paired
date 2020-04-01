require 'rails_helper'

# User Story 36
RSpec.describe "As a visitor", type: :feature do
  describe "when I click on the name of an applicant"
    it "it takes me to the application show page" do
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
      find("#favorite-#{pet_1.id}").click_link("Add To Favorites")

      app_1.pets << pet_1

      visit "/apps/#{app_1.id}"
      within("#pet-#{pet_1.id}") do
        click_link "Approve Application"
      end

      visit "/pets/#{pet_1.id}"

      click_link "On hold for #{app_1.name}"
      expect(page).to have_current_path("/apps/#{app_1.id}")
      expect(page).to have_content(app_1.name)

      visit "/pets/#{pet_1.id}/apps"

      click_link "#{app_1.name}"
      expect(page).to have_current_path("/apps/#{app_1.id}")
      expect(page).to have_content(app_1.name)

  end
end