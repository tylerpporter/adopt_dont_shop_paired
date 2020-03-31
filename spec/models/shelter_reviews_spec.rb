RSpec.describe ShelterReview, type: :model do
  describe 'validations' do
    it {should validate_presence_of :title}
    it {should validate_presence_of :rating}
    it {should validate_presence_of :content}
    it {should validate_presence_of :shelter_id}
  end

  describe 'relationships' do
    it {should belong_to :shelter}
  end

  describe 'instance methods'
    it 'set_defaults' do
      shelter_1 = Shelter.create(name: "Pallet Town Shelter",
                          address: "Route 1",
                          city:  "Pallet Town",
                          state: "Kanto",
                          zip: "80807")
      review1 = ShelterReview.create!(title: "This place is great!",
                              rating: 5,
                              content: "This shelter treats all of its Pokemon (and customers!) with immense care!",
                              shelter_id: shelter_1.id)
      review2 = ShelterReview.create!(title: "This place is ok!",
                              rating: 4,
                              content: "This shelter treats all of its Pokemon (and customers!) with immense care!",
                              picture: "https://img.pokemondb.net/artwork/large/caterpie.jpg",
                              shelter_id: shelter_1.id)

      expect(review1.picture).to eq("site/pokeball.png")
      expect(review2.picture).to eq("https://img.pokemondb.net/artwork/large/caterpie.jpg")
    end

end
