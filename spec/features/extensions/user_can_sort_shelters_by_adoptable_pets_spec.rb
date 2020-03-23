require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "when I visit a shelter index page"
    it "I should see a link to sort shelters by the number of adoptable pets they have" do
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
      pet_1 = Pet.create(image: "https://img.pokemondb.net/artwork/large/pidgey.jpg",
                          name: "Pidgey",
                          description: "Very gentle and loving",
                          approx_age:  4,
                          sex: "Male",
                          status: "Adoptable",
                          shelter_id: shelter_2.id)
      pet_2 = Pet.create(image: "https://img.pokemondb.net/artwork/large/weedle.jpg",
                          name: "Weedle",
                          description: "Weed is a loyal and affectionate friend.",
                          approx_age:  2,
                          sex: "Male",
                          status: "Pending",
                          shelter_id: shelter_2.id)
      pet_3 = Pet.create(image: "https://img.pokemondb.net/artwork/large/pidgey.jpg",
                          name: "Hams",
                          description: "Super shy",
                          approx_age:  4,
                          sex: "Female",
                          status: "Adoptable",
                          shelter_id: shelter_1.id)
      visit "/shelters"

      click_link "Sort Shelters By Adoptable Pets"

      within '.info' do
        expect(page.all('.shelter')[0]).to have_content("#{shelter_2.name}")
        expect(page.all('.shelter')[1]).to have_content("#{shelter_1.name}")
      end
    end
end