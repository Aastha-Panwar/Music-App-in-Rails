class CreateRecentlyPlayeds < ActiveRecord::Migration[7.0]
  def change
    create_table :recently_playeds do |t|
      t.references :listener, null: false, foreign_key: true
      t.references :song, null: false, foreign_key: true
      t.datetime :played_at

      t.timestamps
    end
  end
end
