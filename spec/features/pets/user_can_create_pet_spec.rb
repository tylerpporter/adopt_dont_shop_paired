require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "I can visit the shelter pets index"
    it "can click a link to create pet and see a form to add an adoptable pet" do
      shelter_1 = Shelter.create(name: "Pallet Town Shelter",
                          address: "Route 1",
                          city:  "Pallet Town",
                          state: "Kanto",
                          zip: "80807")

      visit "/shelters/#{shelter_1.id}/pets"

      click_link "Create Pet"

      expect(current_path).to eq("/shelters/#{shelter_1.id}/pets/new")

      fill_in('image', :with => "https://img.pokemondb.net/artwork/large/caterpie.jpg")
      # attach_file('image', Rails.root + 'app/assets/images/pets/https://img.pokemondb.net/artwork/large/caterpie.jpg')
      fill_in('name', :with => "Caterpie")
      fill_in('description', :with => "Loves to cuddle")
      fill_in('approx_age', :with => 3)
      select("Female", :from => "sex")

      click_button "Create Pet"
      # Then a `POST` request is sent to '/shelters/:shelter_id/pets',
      expect(current_path).to eq("/shelters/#{shelter_1.id}/pets")

      expect(page).to have_css("img[src*=caterpie]")
      expect(page).to have_content("Caterpie")
      expect(page).to have_content("3")
      expect(page).to have_content("Female")
      expect(page).to have_content("Adoptable")
  end
end