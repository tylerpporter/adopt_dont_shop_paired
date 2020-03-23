# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
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

pet_1 = Pet.create(image: "https://img.pokemondb.net/artwork/large/pidgey.jpg",
                    name: "Pidgey",
                    description: "Very gentle and loving",
                    approx_age:  4,
                    sex: "Male",
                    status: "Adoptable",
                    shelter_id: shelter_1.id)
pet_2 = Pet.create(image: "https://img.pokemondb.net/artwork/large/weedle.jpg",
                    name: "Weedle",
                    description: "Weed is a loyal and affectionate friend.",
                    approx_age:  2,
                    sex: "Male",
                    status: "Pending",
                    shelter_id: shelter_1.id)

pet_3 = Pet.create(image: "https://img.pokemondb.net/artwork/large/chansey.jpg",
                    name: "Chansey",
                    description: "Can be aggressive",
                    approx_age:  5,
                    sex: "Female",
                    status: "Adoptable",
                    shelter_id: shelter_3.id)

pet_4 = Pet.create(image: "https://img.pokemondb.net/artwork/large/horsea.jpg",
                    name: "Horsea",
                    description: "Shy",
                    approx_age:  6,
                    sex: "Male",
                    status: "Adoptable",
                    shelter_id: shelter_2.id)