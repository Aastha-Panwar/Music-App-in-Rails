class SongsController < ApplicationController
    # before_action :authenticate_request
    before_action :validate_artist, only: [:create, :destroy, :top_played_songs, :update]
    before_action :validate_listner, only: [:show, :recently_played]


  
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
        album_id: @song.album_id,

      }
    end
  
    def index
      @songs = Song.includes(:artist).all.map do |song|
        {
          id: song.id,
          user_id: song.user_id,
          title: song.title,
          genre: song.genre,
          album_id: song.album_id,
          # artist_name: song.artist.username
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

    def top_played_songs
      # user_id = @current_user.id
      # top_songs = Song.where(user_id: user_id).order(play_count: :desc).limit(3)
      top_songs = @current_user.songs.order(play_count: :desc).limit(3)
      render json: top_songs
    end
    
    def recommended_by_genre
      genre = params[:genre]
      recommended_tracks = Song.where(genre: genre).order(play_count: :desc).limit(10)
      render json: recommended_tracks, status: :ok
    end
  
    def search_song_by_genre
      if params[:genre] && params[:genre].length != 0
        songs = Song.where("genre Like ?" ,"%#{params[:genre]}%")
        if songs.length == 0
          render json: { message: "Songs not found" }, status: :unprocessable_entity
        else
          render json: songs, status: 200
        end
      else
        render json: { error: "Please Search Somthing" }, status: 400
      end
    end

    def search_song_by_title
      if params[:title] && params[:title].length != 0
        songs = Song.where("title Like ?" ,"%#{params[:title]}%")
        if songs.length == 0
          render json: { message: "Songs not found" }, status: :unprocessable_entity
        else
          render json: songs, status: 200
        end
      else
        render json: { error: "Please Search Somthing" }, status: 400
      end
    end
  
    private

    def validate_artist
      if @current_user.user_type != 'Artist'
        render json: { error: 'Listener are Not Allowed for this request' }, status: :forbidden
      end
    end  

    def validate_listner
      if @current_user.user_type != 'Listner'
        render json: { error: 'Artist are Not Allowed for this request' }, status: 400
      end
    end
  
    def song_params
      params.permit(:title, :genre, :album_id, :audio_files)
    end
  
    def song_owner?(song)
      # Check if the current user is the owner (artist) of the song
      song.user_id == @current_user.id
    end
  end
  