class CreateResults < ActiveRecord::Migration[5.0]
  def change
    create_table :results do |t|
      t.references :event, foreign_key: true
      t.references :competitor, foreign_key: true
      t.integer :place
      t.integer :points

      t.timestamps
    end
  end
end
