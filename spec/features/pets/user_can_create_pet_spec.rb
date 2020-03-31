require 'rails_helper'

RSpec.describe "As a visitor" do
  before :each do
    @shelter_1 = Shelter.create(name: "Pallet Town Shelter",
                        address: "Route 1",
                        city:  "Pallet Town",
                        state: "Kanto",
                        zip: "80807")

  end
  describe "I can visit the shelter pets index"
    it "can click a link to create pet and see a form to add an adoptable pet" do
      visit "/shelters/#{@shelter_1.id}/pets"

      click_link "Create Pet"

      expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets/new")

      fill_in('image', :with => "https://img.pokemondb.net/artwork/large/caterpie.jpg")
      fill_in('name', :with => "Caterpie")
      fill_in('description', :with => "Loves to cuddle")
      fill_in('approx_age', :with => 3)
      select("Female", :from => "sex")

      click_button "Create Pet"

      expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets")
      expect(page).to have_css("img[src*=caterpie]")
      expect(page).to have_content("Caterpie")
      expect(page).to have_content("3")
      expect(page).to have_content("Female")
      expect(page).to have_content("Adoptable")
  end
  describe "when I visit /shelters/:id/pets"
    it "If I try to submit the form with incomplete info, I get errors" do
      visit "/shelters/#{@shelter_1.id}/pets"

      fill_in('image', :with => "")
      fill_in('name', :with => "Caterpie")
      fill_in('description', :with => "")
      fill_in('approx_age', :with => 3)
      select("Female", :from => "sex")

      click_button "Create Pet"

      within("") do
        expect(page).to have_content("Please fill out the following fields:")
        expect(page).to have_content("Image")
        expect(page).to have_content("Description")
      end

  end
end