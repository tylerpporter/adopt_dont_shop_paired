
require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "when I visit /shelters/:id"
    it "I see a link to delete a new review next to a review, which deletes the review" do
      shelter_1 = Shelter.create(name: "Pallet Town Shelter",
                          address: "Route 1",
                          city:  "Pallet Town",
                          state: "Kanto",
                          zip: "80807")
      review1 = ShelterReview.create!(title: "This place is great!",
                              rating: 5,
                              content: "This shelter treats all of its Pokemon (and customers!) with immense care!",
                              picture: "https://img.pokemondb.net/artwork/large/caterpie.jpg",
                              shelter_id: shelter_1.id)
      review2 = ShelterReview.create!(title: "This place is pretty good!",
                              rating: 4,
                              content: "This shelter treats all of its Pokemon pretty good!",
                              shelter_id: shelter_1.id)
      visit "/shelters/#{shelter_1.id}"

      find("#shelter-review-#{review1.id}").click_link "Delete Review"

      expect(current_path).to eq("/shelters/#{shelter_1.id}")

      expect(page).to have_no_content("This place is great!")
      expect(page).to have_no_content(5)
      expect(page).to have_no_content("This shelter treats all of its Pokemon (and customers!) with immense care!")
      expect(page).to have_no_css("img[src*=caterpie]")

      expect(page).to have_content("This place is pretty good!")
      expect(page).to have_content(4)
      expect(page).to have_content("This shelter treats all of its Pokemon pretty good!")
  end
end
