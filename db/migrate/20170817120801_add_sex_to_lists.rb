class AddSexToLists < ActiveRecord::Migration[5.0]
  def change
    add_column :lists, :sex, :string
  end
end
