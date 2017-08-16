class CreateJoinTableEventsCompetitors < ActiveRecord::Migration[5.0]
  def change
    create_join_table :events, :competitors do |t|
      # t.index [:event_id, :competitor_id]
      # t.index [:competitor_id, :event_id]
    end
  end
end
