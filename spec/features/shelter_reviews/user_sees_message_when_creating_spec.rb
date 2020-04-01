require 'rails_helper'

# User Story 4
RSpec.describe "As a visitor", type: :feature do
  before :each do
    @shelter1 = Shelter.create(name: "Pallet Town Shelter",
                        address: "Route 1",
                        city:  "Pallet Town",
                        state: "Kanto",
                        zip: "80807")

  end
  describe "when I visit /shelters/:id"
    it "I see a link to create a new review, fill out form with missing data" do
      visit "/shelters/#{@shelter1.id}"

      click_link "Add Review"

      fill_in('title', :with => "")
      fill_in('content', :with => "This shelter treats all of its Pokemon (and customers!) with immense care!")
      fill_in('picture', :with => "https://img.pokemondb.net/artwork/large/caterpie.jpg")

      click_button "Create Review"

      expect(current_path).to eq("/shelter_reviews/#{@shelter1.id}/new")
      within '.error' do
        expect(page).to have_content("Please fill out the following fields:")
        expect(page).to have_content("Title")
        expect(page).to have_no_content("Content")
      end

      fill_in('title', :with => "Title")
      fill_in('content', :with => "")
      fill_in('picture', :with => "https://img.pokemondb.net/artwork/large/caterpie.jpg")

      click_button "Create Review"

      expect(current_path).to eq("/shelter_reviews/#{@shelter1.id}/new")
      within '.error' do
        expect(page).to have_content("Please fill out the following fields:")
        expect(page).to have_no_content("Title")
        expect(page).to have_content("Content")
      end
  end
end
