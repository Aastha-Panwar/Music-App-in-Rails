class MergePlaylist < ApplicationRecord
  belongs_to :listener
  belongs_to :playlist1
  belongs_to :playlist2
end
