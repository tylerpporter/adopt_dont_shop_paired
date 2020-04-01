require 'rails_helper'

RSpec.describe "As a visitor" do
  before :each do
    @shelter1 = Shelter.create(name: "Pallet Town Shelter",
                        address: "Route 1",
                        city:  "Pallet Town",
                        state: "Kanto",
                        zip: "80807")
    @review1 = ShelterReview.create!(title: "This place is great!",
                            rating: 5,
                            content: "This shelter treats all of its Pokemon (and customers!) with immense care!",
                            picture: "https://img.pokemondb.net/artwork/large/caterpie.jpg",
                            shelter_id: @shelter1.id)
  end
  # User Story 5
  describe "when I visit /shelters/:id"
    it "I see a link to edit the shelter review next to each review" do

      visit "/shelters/#{@shelter1.id}"

      within("#shelter-review-#{@review1.id}") do
        click_link "Edit"
      end

      expect(current_path).to eq("/shelters/#{@shelter1.id}/#{@review1.id}/edit")
    end
  # User Story 5
  describe "when I visit /shelters/:shelter_id/:review_id/edit"
    it "I can fill out a form to update the review" do

      visit "/shelters/#{@shelter1.id}/#{@review1.id}/edit"

      fill_in :title, with: "This place is garbage!"
      fill_in :rating, with: 1
      fill_in :content, with: "I hated everything about this shelter!"
      click_button "Update Review"

      expect(current_path).to eq("/shelters/#{@shelter1.id}")

      within("#shelter-review-#{@review1.id}") do
        expect(page).to have_content("This place is garbage!")
        expect(page).to have_content(1)
        expect(page).to have_content("I hated everything about this shelter!")
        expect(page).to have_css("img[src*=caterpie]")
      end
    end
    # User Story 6
    it "I can't upate the review if all fields are not entered" do

      visit "/shelters/#{@shelter1.id}/#{@review1.id}/edit"
      fill_in :title, with: "This place is garbage!"
      fill_in :rating, with: 1
      fill_in :content, with: ""
      click_button "Update Review"

      expect(current_path).to eq("/shelters/#{@shelter1.id}/#{@review1.id}/edit")
      expect(page).to have_content("Please fill out the following fields: ")
      expect(page).to have_content("Content")
    end
end
