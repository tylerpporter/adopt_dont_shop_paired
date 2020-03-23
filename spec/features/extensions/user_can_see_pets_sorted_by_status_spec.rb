require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "when I visit a shelter pets index page"
    it "I can see a count of the number of pets at the shelter" do
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
                          status: "Pending",
                          shelter_id: shelter_1.id)
      pet_2 = Pet.create(image: "https://img.pokemondb.net/artwork/large/weedle.jpg",
                          name: "Weedle",
                          description: "Weed is a loyal and affectionate friend.",
                          approx_age:  2,
                          sex: "Male",
                          status: "Adoptable",
                          shelter_id: shelter_1.id)

      visit "/shelters/#{shelter_1.id}/pets"

      within '.all-pets' do
        expect(page.all('.pet-info')[0]).to have_content("#{pet_2.name}")
        expect(page.all('.pet-info')[1]).to have_content("#{pet_1.name}")
      end
    end
end