class AddAdoptedToPets < ActiveRecord::Migration[5.1]
  def change
    add_column :pets, :adopted, :string
  end
end
