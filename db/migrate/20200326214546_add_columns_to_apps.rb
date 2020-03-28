class AddColumnsToApps < ActiveRecord::Migration[5.1]
  def change
    add_column :apps, :name, :string
    add_column :apps, :address, :string
    add_column :apps, :city, :string
    add_column :apps, :state, :string
    add_column :apps, :zip, :string
    add_column :apps, :phone_number, :string
    add_column :apps, :description, :string
  end
end
