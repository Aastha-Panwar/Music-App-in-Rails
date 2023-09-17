class CreateRecommendedTracks < ActiveRecord::Migration[7.0]
  def change
    create_table :recommended_tracks do |t|
      t.references :listener, null: false, foreign_key: true
      t.references :song, null: false, foreign_key: true

      t.timestamps
    end
  end
end
