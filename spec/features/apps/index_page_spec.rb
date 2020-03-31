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
    find("#favorite-#{@pet1.id}").click_link("Add To Favorites")
    @app1.pets << @pet1
    @app2.pets << @pet1
  end
  describe "When I visit a pet's show page"
  it "I see a link to view all applications for this pet" do
    visit "/pets/#{@pet1.id}"
    click_link "Applications"

    expect(current_path).to eq("/pets/#{@pet1.id}/apps")
    expect(page).to have_content(@app1.name)
    expect(page).to have_content(@app2.name)

    click_link("#{@app1.name}")

    expect(current_path).to eq("/apps/#{@app1.id}")
  end
  describe "When I visit a pet's application index page"
  it "I see a no applications message if that pet has no applications on them" do
    visit "/pets/#{@pet2.id}/apps"

    expect(page).to_not have_content(@app1.name)
    expect(page).to have_content("There are no applications for this pet yet.")
  end

end
