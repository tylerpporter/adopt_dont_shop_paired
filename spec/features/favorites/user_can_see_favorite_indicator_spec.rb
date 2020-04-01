require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "when I visit any page"
    it "I can see a favorite indicator in the nav bar, which shows a count of favorite pets" do
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
    visit "/"
    within("nav") do
      expect(page).to have_link("Favorites (0)")
    end

    visit "/pets"
    within("nav") do
      expect(page).to have_link("Favorites (0)")
    end

    visit "/pets/#{pet_1.id}"
    within("nav") do
      expect(page).to have_link("Favorites (0)")
    end

    visit "/shelters"
    within("nav") do
      expect(page).to have_link("Favorites (0)")
    end

    visit "/shelters/#{shelter_1.id}"
    within("nav") do
      expect(page).to have_link("Favorites (0)")
    end

    visit "/shelters/#{shelter_1.id}/pets"
    within("nav") do
      expect(page).to have_link("Favorites (0)")
    end

    visit "/pets/#{pet_1.id}"
    find("#favorite-#{pet_1.id}").click_link("Add To Favorites")
    within("nav") do
      expect(page).to have_content("Favorites (1)")
    end

  end
end
