class SongsController < ApplicationController
    # before_action :authenticate_request
  
    # Add song action
    def create
      song = @current_user.songs.new(song_params)
      if song.save
        render json: { message: 'Song added successfully' }, status: :created
      else
        render json: { error: song.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def show
      @song = Song.find(params[:id])
      render json: {
        user_id: @song.user_id,
        title: @song.title,
        genre: @song.genre,
        album_id: @song.album_id
      }
    end
  
    def index
      @songs = Song.all.map do |song|
        {
          id: song.id,
          user_id: song.user_id,
          title: song.title,
          genre: song.genre,
          album_id: song.album_id
        }
      end
      render json: @songs
    end
  
    # Update song action
    def update
      song = Song.find(params[:id])
      if song_owner?(song)
        if song.update(song_params)
          render json: { message: 'Song updated successfully' }
        else
          render json: { error: song.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { error: 'You are not authorized to update this song' }, status: :unauthorized
      end
    end
  
    # Delete song action
    def destroy
      song = Song.find(params[:id])
      if song_owner?(song)
        song.destroy
        render json: { message: 'Song deleted successfully' }
      else
        render json: { error: 'You are not authorized to delete this song' }, status: :unauthorized
      end
    end
  
    private
  
    def song_params
      params.permit(:title, :genre, :album_id, :audio_files)
    end
  
    def song_owner?(song)
      # Check if the current user is the owner (artist) of the song
      song.user_id == @current_user.id
    end
  end
  

# class SongsController < ApplicationController
#     # before_action :authenticate_request
    
#     # Add song action
#     def create
#         song = @current_user.songs.new(song_params)
#         if song.save
#             render json: { message: 'Song added successfully' }, status: :created
#         else
#             render json: { error: song.errors.full_messages }, status: :unprocessable_entity
#         end
#     end
    
#     def show
#         @song = Song.find(params[:id])
#         render json: {
#         # audio_file_url: rails_blob_url(@song.audio_files),
#         # song_url: @song.audio_files.url,  # Assuming you have an attachment named 'songfile'
#         user_id: @song.user_id,
#         title: @song.title,
#         genre: @song.genre,
#         album_id: @song.album_id
#     }
#     end


#     def index
#         @songs = Song.all.map do |song|
#             {
#             id: song.id,
#             # audio_file_url: rails_blob_url(@song.audio_files),
#             # song_url: song.audio_files.url,  # Assuming you have an attachment named 'songfile'
#             user_id: song.user_id,  # Assuming 'artist' is an association in your Song model
#             title: song.title,
#             genre: song.genre,
#             album_id: song.album_id
#         }
#     end
#     render json: @songs
#     end

#     # Update song action
#     def update
#         song = Song.find(params[:id])
#         if song.update(song_params)
#             render json: { message: 'Song updated successfully' }
#         else
#             render json: { error: song.errors.full_messages }, status: :unprocessable_entity
#         end
#     end

#     # Delete song action
#     def destroy
#         song = Song.find(params[:id])
#         song.destroy
#         render json: { message: 'Song deleted successfully' }
#     end

#     private

#     def song_params
#         params.permit(:title, :genre, :user_id, :album_id, :audio_files)
#     end

# #   def song_params
# #     params.require(:song).permit(:title, :genre, :other_attributes)
# #   end

# end
