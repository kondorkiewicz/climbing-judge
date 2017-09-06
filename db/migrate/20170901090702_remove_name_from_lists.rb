class RemoveNameFromLists < ActiveRecord::Migration[5.1]
  def change
    remove_column :lists, :name, :string
  end
end
