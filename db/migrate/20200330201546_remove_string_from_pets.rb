class RemoveStringFromPets < ActiveRecord::Migration[5.1]
  def change
    remove_column :pets, :string, :string
  end
end
