require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "when i visit /shelters/:id"
    it "I see a link to edit the shelter review next to each review" do
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

      visit "/shelters/#{shelter_1.id}"

      within("#shelter-review-#{review1.id}") do
        click_link "edit"
      end

      expect(current_path).to eq("/shelters/#{shelter_1.id}/edit_review")
  end
end
