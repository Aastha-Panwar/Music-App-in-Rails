class RecentlyPlayed < ApplicationRecord
  belongs_to :listener, class_name: 'User', foreign_key: 'listener_id'
  belongs_to :song
end
