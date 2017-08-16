class CreateScores < ActiveRecord::Migration[5.0]
  def change
    create_table :scores do |t|
      t.references :list, foreign_key: true
      t.references :competitor, foreign_key: true
      t.integer :start_number
      t.decimal :score
      t.integer :place
      t.decimal :ex_points

      t.timestamps
    end
  end
end
