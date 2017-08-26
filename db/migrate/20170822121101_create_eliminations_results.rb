class CreateEliminationsResults < ActiveRecord::Migration[5.0]
  def change
    create_table :eliminations_results do |t|
      t.integer :place
      t.references :competitor, foreign_key: true
      t.references :event, foreign_key: true
      t.decimal :points
      t.integer :first_route_place
      t.integer :second_route_place
    end
  end
end
