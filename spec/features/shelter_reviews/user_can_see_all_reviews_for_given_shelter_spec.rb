require 'rails_helper'

# User Story 2
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
    it "I see a list of reviews for that shelter" do

      visit "/shelters/#{@shelter1.id}"

      expect(page).to have_content(@review1.title)
      expect(page).to have_content(@review1.rating)
      expect(page).to have_content(@review1.content)
      expect(page).to have_css("img[src*=caterpie]")

      expect(page).to have_content(@review2.title)
      expect(page).to have_content(@review2.rating)
      expect(page).to have_content(@review2.content)
  end
end