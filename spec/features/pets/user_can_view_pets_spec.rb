require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "when I visit /pets"
    it "I can see all pets" do
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
      pet_2 = Pet.create(image: "https://img.pokemondb.net/artwork/large/weedle.jpg",
                        name: "Weedle",
                        description: "Weed is a loyal and affectionate friend.",
                        approx_age:  2,
                        sex: "Male",
                        status: "Pending",
                        shelter_id: shelter_1.id)
      visit "/pets"

      expect(page).to have_css("img[src*=pidgey]")
      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(pet_1.approx_age)
      expect(page).to have_content(pet_1.sex)
      expect(page).to have_content(shelter_1.name)
      expect(page).to have_css("img[src*=weedle]")
      expect(page).to have_content(pet_2.name)
      expect(page).to have_content(pet_2.approx_age)
      expect(page).to have_content(pet_2.sex)
      expect(page).to have_content(shelter_1.name)
    end
end
