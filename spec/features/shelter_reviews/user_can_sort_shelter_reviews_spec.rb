require 'rails_helper'

# User Story 39
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
  describe "When I visit a shelter's show page to see their reviews"
    it "I see links to sort the reviews by highest rating and lowest rating" do

      visit "/shelters/#{@shelter1.id}"

      expect(page).to have_content("Sort By Highest Rating")
      expect(page).to have_content("Sort By Lowest Rating")
  end
  describe "When I visit a shelter's show page to see their reviews"
    it "I can sort by highest rating" do

      visit "/shelters/#{@shelter1.id}"

      click_link "Sort By Highest Rating"

      within(".all-reviews") do
        expect(page.all('.reviews')[0]).to have_content("#{@review1.title}")
        expect(page.all('.reviews')[1]).to have_content("#{@review2.title}")
      end
  end
  describe "When I visit a shelter's show page to see their reviews"
    it "I can sort by lowest rating" do

      visit "/shelters/#{@shelter1.id}"

      click_link "Sort By Lowest Rating"

      within(".all-reviews") do
        expect(page.all('.reviews')[0]).to have_content("#{@review2.title}")
        expect(page.all('.reviews')[1]).to have_content("#{@review1.title}")
      end
  end

end