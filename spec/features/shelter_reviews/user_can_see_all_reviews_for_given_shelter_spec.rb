require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "when I visit /shelters/:id"
    it "I see a list of reviews for that shelter" do
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

      # expect(shelter_1.shelter_reviews).to have_content(review1)
      # expect(shelter_1.shelter_reviews).to have_content(review2)
      # expect(page).to have_content(shelter_1.shelter_reviews)
      expect(page).to have_content("This place is great!")
      expect(page).to have_content("This shelter treats all of its Pokemon (and customers!) with immense care!")
          
  end
end
