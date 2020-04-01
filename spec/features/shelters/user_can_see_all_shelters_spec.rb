require 'rails_helper'

RSpec.describe "As a visitor", type: :feature do
  describe "when I visit /shelters"
  it "I can see all shelters" do
    shelter_1 = Shelter.create(name: "Pallet Town Shelter",
                        address: "Route 1",
                        city:  "Pallet Town",
                        state: "Kanto",
                        zip: "80807")
    shelter_2 = Shelter.create(name: "Cerulean City Center",
                        address: "Route 5",
                        city:  "Cerulean City",
                        state: "Kanto",
                        zip: "80808")
    shelter_3 = Shelter.create(name: "Safari Zone Rescue",
                        address: "Route 48",
                        city:  "Fuchsia City",
                        state: "Kanto",
                        zip: "80809")
    visit "/shelters"

    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content(shelter_2.name)
    expect(page).to have_content(shelter_3.name)
  end
  it "I see the top 3 highest rated shelters" do
    shelter1 = Shelter.create(name: "Pallet Town Shelter",
                        address: "Route 1",
                        city:  "Pallet Town",
                        state: "Kanto",
                        zip: "80807")
    shelter2 = Shelter.create(name: "Cerulean City Center",
                        address: "Route 5",
                        city:  "Cerulean City",
                        state: "Kanto",
                        zip: "80808")
    shelter3 = Shelter.create(name: "Safari Zone Rescue",
                        address: "Route 48",
                        city:  "Fuchsia City",
                        state: "Kanto",
                        zip: "80809")
    shelter4 = Shelter.create(name: "Safari Zone Rescue",
                        address: "Route 48",
                        city:  "Fuchsia City",
                        state: "Kanto",
                        zip: "80809")
    review1 = ShelterReview.create!(title: "This place is great!",
                            rating: 4,
                            content: "This shelter treats all of its Pokemon (and customers!) with immense care!",
                            picture: "https://img.pokemondb.net/artwork/large/caterpie.jpg",
                            shelter_id: shelter1.id)
    review2 = ShelterReview.create!(title: "This place is ok!",
                            rating: 5,
                            content: "This shelter treats all of its Pokemon (and customers!) with immense care!",
                            picture: "https://img.pokemondb.net/artwork/large/caterpie.jpg",
                            shelter_id: shelter2.id)
    review3 = ShelterReview.create!(title: "This place is fine!",
                            rating: 1,
                            content: "This shelter treats all of its Pokemon (and customers!) with immense care!",
                            picture: "https://img.pokemondb.net/artwork/large/caterpie.jpg",
                            shelter_id: shelter3.id)
    review4 = ShelterReview.create!(title: "This place is alright!",
                            rating: 3,
                            content: "This shelter treats all of its Pokemon (and customers!) with immense care!",
                            picture: "https://img.pokemondb.net/artwork/large/caterpie.jpg",
                            shelter_id: shelter4.id)
    visit "/shelters"

    within ".highest-rated" do
      expect(page).to have_link(shelter2.name)
      expect(page).to have_link(shelter1.name)
      expect(page).to have_link(shelter4.name)
      shelter2.name.should appear_before(shelter1.name)
      shelter2.name.should appear_before(shelter4.name)
      shelter1.name.should appear_before(shelter4.name)
    end
  end

  describe "when I visit /shelters/:id"
    it "can see all shelter information" do
      shelter_1 = Shelter.create(name: "Pallet Town Shelter",
                          address: "Route 1",
                          city:  "Pallet Town",
                          state: "Kanto",
                          zip: "80807")
      shelter_2 = Shelter.create(name: "Cerulean City Center",
                          address: "Route 5",
                          city:  "Cerulean City",
                          state: "Kanto",
                          zip: "80808")

      visit "/shelters/#{shelter_1.id}"

      expect(page).to have_content(shelter_1.name)
      expect(page).to have_content("Address: #{shelter_1.address}")
      expect(page).to have_content("City: #{shelter_1.city}")
      expect(page).to have_content("State: #{shelter_1.state}")
      expect(page).to have_content("Zip: #{shelter_1.zip}")

      visit "/shelters/#{shelter_2.id}"

      expect(page).to have_content(shelter_2.name)
      expect(page).to have_content("Address: #{shelter_2.address}")
      expect(page).to have_content("City: #{shelter_2.city}")
      expect(page).to have_content("State: #{shelter_2.state}")
      expect(page).to have_content("Zip: #{shelter_2.zip}")
  end
  describe "when I visit /shelters/:id"
  it "can see all shelter statistics" do
    shelter1 = Shelter.create(name: "Pallet Town Shelter",
                        address: "Route 1",
                        city:  "Pallet Town",
                        state: "Kanto",
                        zip: "80807")
    pet1 = Pet.create(image: "https://img.pokemondb.net/artwork/large/pidgey.jpg",
                      name: "Pidgey",
                      description: "Very gentle and loving",
                      approx_age:  4,
                      sex: "Male",
                      status: "Adoptable",
                      shelter_id: shelter1.id)
    app1 = App.create(name: "Misty",
                      address: "123 Staryu St.",
                      city: "Cerulean City",
                      state: "Kanto",
                      zip: "80005",
                      phone_number: "555-555-1234",
                      description: "I am a compassionate and caring water pokemon trainer!",
                      pets: [pet1])
    review1 = ShelterReview.create!(title: "This place is great!",
                            rating: 5,
                            content: "This shelter treats all of its Pokemon (and customers!) with immense care!",
                            picture: "https://img.pokemondb.net/artwork/large/caterpie.jpg",
                            shelter_id: shelter1.id)
    review2 = ShelterReview.create!(title: "This place is ok!",
                            rating: 3,
                            content: "This shelter treats all of its Pokemon (and customers!) with immense care!",
                            picture: "https://img.pokemondb.net/artwork/large/caterpie.jpg",
                            shelter_id: shelter1.id)
    visit "/shelters/#{shelter1.id}"

    expect(page).to have_content("Pet Count: 1")
    expect(page).to have_content("Average Rating: 4.0")
    expect(page).to have_content("Number of Applications: 1")
  end
end
