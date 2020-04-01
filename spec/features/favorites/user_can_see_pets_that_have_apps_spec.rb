require 'rails_helper'

RSpec.describe 'As a visitor' do
  before :each do
    @shelter1 = Shelter.create(name: "Pallet Town Shelter",
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
    @pet3 = Pet.create(image: "https://img.pokemondb.net/artwork/large/weedle.jpg",
                      name: "Tom",
                      description: "Party animal.",
                      approx_age:  4,
                      sex: "Male",
                      status: "Pending",
                      shelter_id: @shelter1.id)
    @app1 = App.create(name: "Misty",
                      address: "123 Staryu St.",
                      city: "Cerulean City",
                      state: "Kanto",
                      zip: "80005",
                      phone_number: "555-555-1234",
                      description: "I am a compassionate and caring water pokemon trainer!")
    @app2 = App.create(name: "Ash",
                      address: "123 Pika St.",
                      city: "Pallet Town",
                      state: "Kanto",
                      zip: "80005",
                      phone_number: "555-555-4321",
                      description: "I'm gonna be the best Pokemon trainer in the world!")

    visit "/pets/#{@pet1.id}"
    find("#favorite-#{@pet1.id}").click
    visit "/pets/#{@pet2.id}"
    find("#favorite-#{@pet2.id}").click
    visit "/pets/#{@pet3.id}"
    find("#favorite-#{@pet3.id}").click
    @app1.pets << @pet1
    @app2.pets << @pet1
    @app2.pets << @pet2
    visit "/favorites"
  end
  describe "When I visit /favorites"
  it "I see a list of all pets that have at least 1 application on them" do

    within ".pets-with-apps" do
      expect(page).to have_content(@pet1.name)
      expect(page).to have_content(@pet2.name)
      expect(page).to_not have_content(@pet3.name)

      click_link "#{@pet1.name}"

      expect(current_path).to eq("/pets/#{@pet1.id}")
    end
  end
  it "I see a list of all pets that have an approved application on them" do
    within ".approved-pets" do
      expect(page).to have_link(@pet2.name)
      expect(page).to have_link(@pet3.name)

      click_link "#{@pet2.name}"

      expect(current_path).to eq("/pets/#{@pet2.id}")
    end
  end
end
