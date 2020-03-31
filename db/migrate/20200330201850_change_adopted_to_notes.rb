class ChangeAdoptedToNotes < ActiveRecord::Migration[5.1]
  def change
    rename_column :pets, :adopted, :notes
  end
end
