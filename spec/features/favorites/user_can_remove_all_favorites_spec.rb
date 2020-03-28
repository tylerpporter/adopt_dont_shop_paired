require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "when I have added pets to my favorites and visit /favorites"
  it "I see a link to remove all favorite pets that removes all favorited pets" do
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
    pet_2 = Pet.create(image: "https://img.pokemondb.net/artwork/large/weedle.jpg",
                      name: "Weedle",
                      description: "Weed is a loyal and affectionate friend.",
                      approx_age:  2,
                      sex: "Male",
                      status: "Pending",
                      shelter_id: shelter_1.id)

    visit "/pets/#{pet_1.id}"
    find("#favorite-#{pet_1.id}").click_link("Add To Favorites")

    visit "/pets/#{pet_2.id}"
    find("#favorite-#{pet_2.id}").click_link("Add To Favorites")

    within("nav") do
      expect(page).to have_content("Favorites (2)")
    end

    visit "/favorites"
    click_link "Remove all pets"

    expect(current_path).to eq("/favorites")
    within("nav") do
      expect(page).to have_content("Favorites")
    end
    expect(page).to have_content("I have no favorited pets")

  end
end