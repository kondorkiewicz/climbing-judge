class CreateLists < ActiveRecord::Migration[5.0]
  def change
    create_table :lists do |t|
      t.references :event, foreign_key: true
      t.string :round

      t.timestamps
    end
  end
end
