require 'rails_helper'

RSpec.describe "As a visitor" do
  before :each do
    @shelter_1 = Shelter.create(name: "Pallet Town Shelter",
                        address: "Route 1",
                        city:  "Pallet Town",
                        state: "Kanto",
                        zip: "80807")
    @pet_1 = Pet.create(image: "https://img.pokemondb.net/artwork/large/pidgey.jpg",
                        name: "Pidgey",
                        description: "Very gentle and loving",
                        approx_age:  4,
                        sex: "Male",
                        status: "Adoptable",
                        shelter_id: @shelter_1.id)
    @pet_2 = Pet.create(image: "https://img.pokemondb.net/artwork/large/weedle.jpg",
                        name: "Weedle",
                        description: "Weed is a loyal and affectionate friend.",
                        approx_age:  2,
                        sex: "Male",
                        status: "Pending",
                        shelter_id: @shelter_1.id)
  end
  describe "I can visit a pet show page"
    it "can click a link to delete pet and redirected to the pet index" do
      visit "/pets/#{@pet_1.id}"

      click_link "Delete"

      expect(current_path).to eq("/pets")

      expect(page).to have_no_css("img[src*=caterpie]")
      expect(page).to have_no_content(@pet_1.name)
      expect(page).to have_no_content(@pet_1.approx_age)

      expect(page).to have_css("img[src*=weedle]")
      expect(page).to have_content(@pet_2.name)
      expect(page).to have_content(@pet_2.approx_age)
      expect(page).to have_content(@pet_2.sex)
      expect(Pet.count).to eq(1)
  end
  describe "If I've added a pet to my favorites"
    it "I can delete the pet which also removes it from my favorites" do
      visit "/pets/#{@pet_1.id}"

      find("#favorite-#{@pet_1.id}").click_link("Add To Favorites")

      within("nav") do
        expect(page).to have_content("Favorites (1)")
      end

      visit "/pets/#{@pet_1.id}"
      click_link "Delete"

      visit "/favorites"
      within("nav") do
        expect(page).to have_content("Favorites")
      end
      expect(page).to have_content("I have no favorited pets")

  end

end