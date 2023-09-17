class CreateMergePlaylists < ActiveRecord::Migration[7.0]
  def change
    create_table :merge_playlists do |t|
      t.references :listener, null: false, foreign_key: true
      t.references :playlist1, null: false, foreign_key: true
      t.references :playlist2, null: false, foreign_key: true

      t.timestamps
    end
  end
end
