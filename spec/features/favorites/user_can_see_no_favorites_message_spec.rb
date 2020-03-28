require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "when I visit /favorites"
    it "I can see a message stating I have no favorite pets when no pets have been favorited" do
      shelter_1 = Shelter.create!(name: "Pallet Town Shelter",
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

      visit "/favorites"

      expect(page).to have_content("I have no favorited pets")
  end
end
