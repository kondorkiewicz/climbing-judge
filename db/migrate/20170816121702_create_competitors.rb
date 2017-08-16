class CreateCompetitors < ActiveRecord::Migration[5.0]
  def change
    create_table :competitors do |t|
      t.string :name
      t.string :surname
      t.string :sex
      t.string :club
      t.date :birth_date

      t.timestamps
    end
  end
end
