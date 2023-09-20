class Song < ApplicationRecord
  belongs_to :artist, class_name: 'User', foreign_key: 'user_id'
  belongs_to :album,  optional: true
  has_many_attached :audio_files #Active Storage for file attachments

  has_many :playlist_songs, dependent: :destroy
  has_many :playlists, through: :playlist_songs

end
