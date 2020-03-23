class CreateShelterReview < ActiveRecord::Migration[5.1]
  def change
    create_table :shelter_reviews do |t|
      t.string :title
      t.integer :rating
      t.string :content
      t.string :picture

      t.timestamps
    end
  end
end
