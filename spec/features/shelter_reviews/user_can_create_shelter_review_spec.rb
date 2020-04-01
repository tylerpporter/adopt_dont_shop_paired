require 'rails_helper'

# User Story 3
RSpec.describe "As a visitor", type: :feature do
  before :each do
    @shelter1 = Shelter.create(name: "Pallet Town Shelter",
                        address: "Route 1",
                        city:  "Pallet Town",
                        state: "Kanto",
                        zip: "80807")
  end
  describe "when I visit /shelters/:id"
    it "I can create a shelter review" do
      visit "/shelters/#{@shelter1.id}"

      click_link "Add Review"

      fill_in('title', :with => "This place is great!")
      choose('rating', :with => "5")
      fill_in('content', :with => "This shelter treats all of its Pokemon (and customers!) with immense care!")
      fill_in('picture', :with => "https://img.pokemondb.net/artwork/large/caterpie.jpg")

      click_button "Create Review"

      expect(current_path).to eq("/shelters/#{@shelter1.id}")
      expect(page).to have_css("img[src*=caterpie]")
      expect(page).to have_content("This place is great!")
      expect(page).to have_content("5")
      expect(page).to have_content("This shelter treats all of its Pokemon (and customers!) with immense care!")

      click_link "Add Review"

      fill_in('title', :with => "My first review!!")
      choose('rating', :with => "3")
      fill_in('content', :with => "I love this shelter! People who care!")

      click_button "Create Review"

      expect(current_path).to eq("/shelters/#{@shelter1.id}")
      expect(page).to have_content("My first review!")
      expect(page).to have_content("3")
      expect(page).to have_content("I love this shelter! People who care!")
  end
  describe "I create a new shelter review"
  it "Has a default image" do
    shelter_1 = Shelter.create(name: "Pallet Town Shelter",
                        address: "Route 1",
                        city:  "Pallet Town",
                        state: "Kanto",
                        zip: "80807")
    visit "/shelters/#{shelter_1.id}"

    click_link "Add Review"

    fill_in('title', :with => "This place is great!")
    choose('rating', :with => "5")
    fill_in('content', :with => "This shelter treats all of its Pokemon (and customers!) with immense care!")

    click_button "Create Review"

    review = ShelterReview.last

    expect(review.picture).to eq("site/pokeball.png")
    expect(page).to have_css("img[src*=pokeball]")
  end
end
