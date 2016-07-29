class AddNameToGeek < ActiveRecord::Migration
  def change
    add_column :geeks, :name, :string
  end
end
