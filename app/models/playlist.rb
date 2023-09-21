class Playlist < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  # has_and_belongs_to_many :songs, dependent: :destroy

  has_many :playlist_songs, dependent: :destroy
  has_many :songs, through: :playlist_songs

end
