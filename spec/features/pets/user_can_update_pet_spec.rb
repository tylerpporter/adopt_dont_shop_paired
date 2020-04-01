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
  end

  describe "When I visit a Pet Show page"
    it "I can see a link to update that Pet, when I click it, I can edit pet data" do
    visit "/pets/#{@pet_1.id}"

    click_link "Edit"

    expect(page).to have_current_path("/pets/#{@pet_1.id}/edit")

    fill_in('image', :with => "https://img.pokemondb.net/artwork/large/caterpie.jpg")
    fill_in('name', :with => "Bubbles")
    fill_in('description', :with => "Hates to cuddle")
    fill_in('approx_age', :with => 3)
    fill_in('sex', :with => "Male")

    click_button "Update Pet"

    expect(page).to have_current_path("/pets/#{@pet_1.id}")
    expect(page).to have_css("img[src*=caterpie]")
    expect(page).to have_content("Bubbles")
    expect(page).to have_content("Hates to cuddle")
    expect(page).to have_content("3")
    expect(page).to have_content("Male")
    expect(page).to have_content("Adoptable")
  end
  describe "when I visit /shelters/:id/pets"
    it "If I try to submit the form with incomplete info, I get errors" do
      visit "/pets/#{@pet_1.id}"

      click_link "Edit"

      expect(page).to have_current_path("/pets/#{@pet_1.id}/edit")

      fill_in('image', :with => "https://img.pokemondb.net/artwork/large/caterpie.jpg")
      fill_in('name', :with => "")
      fill_in('description', :with => "Hates to cuddle")
      fill_in('approx_age', :with => "")
      fill_in('sex', :with => "Male")

      click_button "Update Pet"

      within(".error") do
        expect(page).to have_content("Please fill out the following fields:")
        expect(page).to have_content("Name")
        expect(page).to have_content("Age")
      end
  end
end

