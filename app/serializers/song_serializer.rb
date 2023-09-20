class SongSerializer < ActiveModel::Serializer
  attributes :id, :title, :genre, :play_count, :album_id

  # def url
  #   url = object.file.url
  # end

  # def artist_name
  #  object.artist.username
  # end

end
