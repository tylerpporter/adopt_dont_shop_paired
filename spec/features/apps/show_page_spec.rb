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
    @app2 = App.create(name: "Brock",
                      address: "123 Onyx St.",
                      city: "Pewter City",
                      state: "Kanto",
                      zip: "80006",
                      phone_number: "444-444-1234",
                      description: "I'm a certified gym leader")

    visit "/pets/#{@pet1.id}"
    find("#favorite-#{@pet1.id}").click
    visit "/pets/#{@pet2.id}"
    find("#favorite-#{@pet2.id}").click

    @app1.pets << @pet1
    @app1.pets << @pet2

    @app2.pets << @pet1

  end

  describe "When I visit /apps/:id"
    it "I see all of the info for that app" do
      visit "/apps/#{@app1.id}"

      expect(page).to have_content(@app1.name)
      expect(page).to have_content(@app1.address)
      expect(page).to have_content(@app1.city)
      expect(page).to have_content(@app1.state)
      expect(page).to have_content(@app1.zip)
      expect(page).to have_content(@app1.phone_number)
      expect(page).to have_content(@app1.description)
      expect(page).to have_content(@pet1.name)

      click_link "#{@pet1.name}"

      expect(current_path).to eq("/pets/#{@pet1.id}")
  end

  describe "When I visit /apps/:id"
    it "For every pet application, I see a link to approve the application for that specific pet" do
      visit "/apps/#{@app1.id}"
      within("#pet-#{@pet1.id}") do
        click_link "Approve Application"
      end

      expect(current_path).to eq("/pets/#{@pet1.id}")
      expect(page).to have_content("Pending")
      expect(page).to have_content("On hold for #{@app1.name}")
  end

  # User Story 23
  describe "When an application is made for more than one pet and I visit /apps/:id"
    it "I can approve the application for any number of pets" do
      visit "/apps/#{@app1.id}"
      within("#pet-#{@pet1.id}") do
        click_link "Approve Application"
      end

      expect(current_path).to eq("/pets/#{@pet1.id}")
      expect(page).to have_content("Pending")
      expect(page).to have_content("On hold for #{@app1.name}")


      visit "/apps/#{@app1.id}"
      within("#pet-#{@pet2.id}") do
        click_link "Approve Application"
      end

      expect(current_path).to eq("/pets/#{@pet2.id}")
      expect(page).to have_content("Pending")
      expect(page).to have_content("On hold for #{@app1.name}")

  end

  # User Story 24
  describe "When a pet has more than one application made for them and one application approved"
    it "I can not approve any other applications for that pet" do
      visit "/apps/#{@app1.id}"
      within("#pet-#{@pet1.id}") do
        click_link "Approve Application"
      end

      visit "/apps/#{@app2.id}"
      within("#pet-#{@pet1.id}") do
        expect(page).to have_no_link("Approve Application")
      end

      visit "/apps/#{@app1.id}"
      within("#pet-#{@pet1.id}") do
        expect(page).to have_no_link("Approve Application")
      end

      visit "/pets/#{@pet1.id}/apps"
      expect(page).to have_content("Application ##{@app1.id}:")
      expect(page).to have_link("#{@app1.name}")
      expect(page).to have_content("Application ##{@app2.id}:")
      expect(page).to have_link("#{@app2.name}")

  end

end
