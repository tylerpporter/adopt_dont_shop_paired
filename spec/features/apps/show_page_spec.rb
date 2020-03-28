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
    @app1 = App.create(name: "Misty",
                      address: "123 Staryu St.",
                      city: "Cerulean City",
                      state: "Kanto",
                      zip: "80005",
                      phone_number: "555-555-1234",
                      description: "I am a compassionate and caring water pokemon trainer!")

    visit "/pets/#{@pet1.id}"
    find("#favorite-#{@pet1.id}").click
    @app1.pets << @pet1
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
  # 
  # describe "When I visit /apps/:id"
  #   it "For every pet application, I see a link to approve the application for that specific pet" do
  #     visit "/apps/#{@app1.id}"
  #     click_link "Approve Application"
  #     expect(current_path).to eq("/pets/#{@pet1.id}")
  #     expect(page).to have_content("Pending")
  #     expect(page).to have_content("On hold for #{@app1.name}")
  #   end

end
