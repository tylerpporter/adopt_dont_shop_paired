
require 'rails_helper'

# User Story 7
RSpec.describe "As a visitor", type: :feature do
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
    @review2 = ShelterReview.create!(title: "This place is pretty good!",
                            rating: 4,
                            content: "This shelter treats all of its Pokemon pretty good!",
                            shelter_id: @shelter1.id)
  end
  describe "when I visit /shelters/:id"
    it "I see a link to delete a review next to a review, which deletes the review" do
      visit "/shelters/#{@shelter1.id}"

      find("#shelter-review-#{@review1.id}").click_link "Delete"

      expect(current_path).to eq("/shelters/#{@shelter1.id}")

      expect(page).to have_no_content("This place is great!")
      expect(page).to have_no_content(5)
      expect(page).to have_no_content("This shelter treats all of its Pokemon (and customers!) with immense care!")
      expect(page).to have_no_css("img[src*=caterpie]")

      expect(page).to have_content("This place is pretty good!")
      expect(page).to have_content(4)
      expect(page).to have_content("This shelter treats all of its Pokemon pretty good!")
  end
end
