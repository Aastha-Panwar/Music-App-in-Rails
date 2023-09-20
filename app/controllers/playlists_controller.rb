class PlaylistsController < ApplicationController
    
    def index
        playlists = Playlist.all
        render json: playlists
    end

    def show
        playlist = @current_user.playlists.find_by_id(params[:id])
        if playlist
            render json: playlist
        else
            render json: { error: "playlists does not exist" }, status: 400
        end
    end
    
    def create
        playlist = @current_user.playlists.new(playlist_params)
        
        if playlist.save
            render json: { data: playlist, message: 'Playlist created successfully' }, status: :created
        else
            render json: { errors: playlist.errors.full_messages }, status: :unprocessable_entity
        end
    end
    
    # Add a song to a playlist
    def add_song
        playlist = @current_user.playlists.find(params[:id])
        song = Song.find(params[:song_id])
        
        if playlist && song
            playlist.songs << song
            render json: { message: 'Song added to the playlist successfully' }
        else
            render json: { error: 'Playlist or song not found' }, status: :not_found
        end
    end
    
    # Merge two playlists
    def merge
        playlist1 = @current_user.playlists.find(params[:id])
        playlist2 = @current_user.playlists.find(params[:other_playlist_id])
        
        if playlist1 && playlist2
            # Logic to merge playlists
            merged_playlist = merge_logic(playlist1, playlist2)
            
            render json: { message: 'Playlists merged successfully', merged_playlist: merged_playlist }
        else
            render json: { error: 'Playlists not found' }, status: :not_found
        end
    end
    
    # View recently played songs
    def recently_played
        listener = @current_user
        recently_played_songs = listener.recently_playeds.order(played_at: :desc).limit(10).map(&:song)
        
        render json: recently_played_songs, each_serializer: SongSerializer, status: :ok
    end
    
    private
    
    def playlist_params
        params.permit(:title)
    end
    
    def merge_logic(playlist1, playlist2)
        # Implement your logic to merge playlists here
        # You can add songs from playlist2 to playlist1 or vice versa
        # Return the merged playlist
    end
    
end
