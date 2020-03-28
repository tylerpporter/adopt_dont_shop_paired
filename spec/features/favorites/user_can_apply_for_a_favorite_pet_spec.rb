require 'rails_helper'

RSpec.describe 'as a visitor' do
  before :each do
    @shelter1 = Shelter.create!(name: "Pallet Town Shelter",
                        address: "Route 1",
                        city:  "Pallet Town",
                        state: "Kanto",
                        zip: "80807")
    @pet1 = Pet.create(image: "https://img.pokemondb.net/artwork/large/pidgey.jpg",
                      name: "Pidgey",
                      description: "Very gentle and loving",
                      approx_age:  4,
                      sex: "Male",
                      status: "Adoptable",
                      shelter_id: @shelter1.id)
    @pet2 = Pet.create(image: "https://img.pokemondb.net/artwork/large/weedle.jpg",
                      name: "Weedle",
                      description: "Weed is a loyal and affectionate friend.",
                      approx_age:  2,
                      sex: "Male",
                      status: "Pending",
                      shelter_id: @shelter1.id)
    visit "/pets/#{@pet1.id}"
    find("#favorite-#{@pet1.id}").click
    visit "/pets/#{@pet2.id}"
    find("#favorite-#{@pet2.id}").click
    visit "/favorites"
  end
  describe 'when I visit /favorites'
    it 'I see a link for adopting my favorited pets' do

      click_link "Adopt a Pet"

      expect(current_path).to eq("/apps/new")
      expect(page).to have_field(:name)
      expect(page).to have_field(:address)
      expect(page).to have_field(:city)
      expect(page).to have_field(:state)
      expect(page).to have_field(:zip)
      expect(page).to have_field(:phone_number)
      expect(page).to have_field(:description)
    end

  describe 'when I visit /apps/new'
    it "I can fill out a new application form" do
      click_link "Adopt a Pet"

      within "#pet-#{@pet1.id}" do
        check("adopt_pet_")
      end

      within "#pet-#{@pet2.id}" do
        check("adopt_pet_")
      end

      fill_in :name, with: "Misty"
      fill_in :address, with: "123 Staryu St."
      fill_in :city, with: "Cerulean City"
      fill_in :state, with: "Kanto"
      fill_in :zip, with: "80005"
      fill_in :phone_number, with: "555-555-1234"
      fill_in :description, with: "I am a compassionate and caring water pokemon trainer!"
      click_button "Submit Application"

      new_app = App.last

      expect(App.all).to_not be_empty
      expect(new_app.name).to eq("Misty")
      expect(new_app.pets).to eq([@pet1, @pet2])
      expect(@pet1.apps).to eq([new_app])
      expect(@pet2.apps).to eq([new_app])
      expect(current_path).to eq("/favorites")
      expect(page).to have_content("Application submitted successfully!")

      visit "/favorites"

      expect(page).to_not have_content(@pet1.name)
      expect(page).to_not have_content(@pet2.name)
    end
    it "I get an error message if I fail to fill out any of the from fields" do
      click_link "Adopt a Pet"

      within "#pet-#{@pet1.id}" do
        check("adopt_pet_")
      end

      within "#pet-#{@pet2.id}" do
        check("adopt_pet_")
      end

      fill_in :name, with: "Misty"
      fill_in :address, with: "123 Staryu St."
      fill_in :state, with: "Kanto"
      fill_in :zip, with: "80005"
      fill_in :phone_number, with: "555-555-1234"
      fill_in :description, with: "I am a compassionate and caring water pokemon trainer!"
      click_button "Submit Application"

      expect(App.all).to be_empty
      expect(current_path).to eq("/apps/new")
      expect(page).to have_content("Application not submitted. Please complete the required fields.")
    end
end
