class ArtistsController < ApplicationController
    # Other actions and before_action as needed
  
    # Custom action to view an artist's own songs and albums
    def my_songs
        artist = @current_user
        songs = artist.songs
        render json: {
          # artist: artist,
          songs: songs
        }
      end
    
      # Custom action to view an artist's own albums
      def my_albums
        artist = @current_user
        albums = artist.albums
        render json: {
          # artist: artist,
          albums: albums
        }
      end
    
    
  end
  

# class ArtistsController < ApplicationController
#     before_action :authenticate_user, only: [:update, :destroy]

#     def index
#         artists = Artist.all
#         render json: artists
#     end
    
#     # Signup action
#     def create
#         artist = Artist.new(artist_params)
#         if artist.save
#             render json: { message: 'Artist created successfully' }, status: :created
#         else
#             render json: { error: artist.errors.full_messages }, status: :unprocessable_entity
#         end
#     end
    
#     # Login action
#     def login
#         artist = Artist.find_by(email: params[:email])
#         if artist&.authenticate(params[:password])
#             token = artist.generate_jwt
#             render json: { token: token }
#         else
#             render json: { error: 'Invalid email or password' }, status: :unauthorized
#         end
#     end
    
#     # Update action
#     def update
#         if @current_user.update(artist_params)
#             render json: { message: 'Artist details updated successfully' }
#         else
#             render json: { error: @current_user.errors.full_messages }, status: :unprocessable_entity
#         end
#     end
    
#     # Delete account action
#     def destroy
#         @current_user.destroy
#         render json: { message: 'Artist account deleted successfully' }
#     end
    
    
#     private
    
#     def artist_params
#         params.require(:artist).permit(:email, :password, :other_attributes)
#     end
# end
