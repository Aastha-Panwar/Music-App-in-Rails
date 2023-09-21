class PlaylistsController < ApplicationController
  
  # before_action :validate_listner

  before_action :find_playlist, only: [:show, :update, :destroy, :add_song]
  before_action :find_song, only: [:add_song]

  def create
    song_id = params[:song_id]
    unless song_id.present?
      return render json: { error: 'Song ID is required to create a playlist' }, status: :unprocessable_entity
    end

    @playlist = @current_user.playlists.new(playlist_params)
    if @playlist.save
      # Add the specified song to the playlist
      song = Song.find(song_id)
      @playlist.songs << song
      
      render json: { message: 'Playlist created successfully' }, status: :created
    else
      render json: { error: @playlist.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    playlists = Playlist.all
    render json: playlists
  end
  
  # Show details of a specific playlist
  def show
    render json: @playlist
  end
  
  # Update the title of a playlist
  def update
    if playlist_owner?
      if @playlist.update(playlist_params)
        render json: { message: 'Playlist updated successfully' }
      else
        render json: { error: @playlist.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'You are not authorized to update this playlist' }, status: :unauthorized
    end
  end
  
  # Delete a playlist
  def destroy
    if playlist_owner?
      @playlist.destroy
      render json: { message: 'Playlist deleted successfully' }
    else
      render json: { error: 'You are not authorized to delete this playlist' }, status: :unauthorized
    end
  end

  def add_song
    if playlist_owner?
      if @playlist.songs.include?(@song)
        render json: { error: 'Song is already in the playlist' }, status: :unprocessable_entity
      else
        @playlist.songs << @song
        render json: { message: 'Song added to the playlist' }
      end
    else
      render json: { error: 'You are not authorized to modify this playlist' }, status: :unauthorized
    end
  end

  
  private
  
  def playlist_params
    params.permit(:title)
  end
  
  def find_playlist
    @playlist = Playlist.find(params[:id])
  end

  def find_song
    @song = Song.find(params[:song_id])
  end

  
  def playlist_owner?
    @playlist.user_id == @current_user.id
  end
  
end