class RecentlyPlayedsController < ApplicationController
  
  def index
    @recently_playeds = @current_user.recently_playeds.order(played_at: :desc)
    render json: @recently_playeds
  end

  def create
    song = Song.find(params[:song_id])
    recently_played = @current_user.recently_playeds.new(song: song)

    if recently_played.save
      render json: { message: 'Song added to recently played' }, status: :created
    else
      render json: { error: recently_played.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    recently_played = @current_user.recently_playeds.find(params[:id])

    if recently_played.destroy
      render json: { message: 'Song removed from recently played' }
    else
      render json: { error: 'Failed to remove song from recently played' }, status: :unprocessable_entity
    end
  end

end
