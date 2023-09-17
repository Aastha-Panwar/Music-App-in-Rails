class Album < ApplicationRecord
  belongs_to :artist, foreign_key: 'user_id'
  has_many :songs, dependent: :destroy

end
