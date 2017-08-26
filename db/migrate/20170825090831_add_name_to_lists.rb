class AddNameToLists < ActiveRecord::Migration[5.0]
  def change
    add_column :lists, :name, :string
  end
end
