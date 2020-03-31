require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  before :each do
    @shelter1 = Shelter.create(name: "Pallet Town Shelter",
                        address: "Route 1",
                        city:  "Pallet Town",
                        state: "Kanto",
                        zip: "80807")
    @shelter2 = Shelter.create(name: "Cerulean City Center",
                        address: "Route 5",
                        city:  "Cerulean City",
                        state: "Kanto",
                        zip: "80808")
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
  describe "when I visit a shelter show page"
    it "I can click a link to delete shelter, which deletes a shelter" do
      visit "/shelters/#{@shelter2.id}"

      expect(page).to have_content(@shelter2.name)

      click_link "Delete Shelter"

      expect(page).to have_current_path("/shelters")
      expect(page).to have_no_content(@shelter2.name)
      expect(page).to have_content(@shelter1.name)
      expect(Shelter.count).to eq(1)
    end
    it "I cannot delete a shelter if that shelter has an approved pet application" do
      visit "/apps/#{@app1.id}"
      within("#pet-#{@pet1.id}") do
        click_link "Approve Application"
      end
      visit "/shelters/#{@shelter1.id}"

      expect(page).to_not have_link("Delete Shelter")

      visit "/shelters/#{@shelter2.id}"

      expect(page).to have_link("Delete Shelter")
    end
end
