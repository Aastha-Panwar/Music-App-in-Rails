class AlbumsController < ApplicationController
    before_action :authenticate_request
    before_action :find_album, only: [:update, :destroy]
    
    # ...
     def index
        album = Album.all
        render json: album
    end
  
    # Create album action
    def create
      album = @current_user.albums.new(album_params)
      if album.save
        render json: { message: 'Album created successfully' }, status: :created
      else
        render json: { error: album.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # Update album action
    def update
      if album_owner?
        if @album.update(album_params)
          render json: { message: 'Album updated successfully' }
        else
          render json: { error: @album.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { error: 'You are not authorized to update this album' }, status: :unauthorized
      end
    end
  
    # Delete album action
    def destroy
      if album_owner?
        @album.destroy
        render json: { message: 'Album deleted successfully' }
      else
        render json: { error: 'You are not authorized to delete this album' }, status: :unauthorized
      end
    end
  
    private
  
    def album_params
      params.require(:album).permit(:title)
    end
  
    def find_album
      @album = Album.find(params[:id])
    end
  
    def album_owner?
      # Check if the current user is the owner (artist) of the album
      @album.user_id == @current_user.id
    end
  end
  


# class AlbumsController < ApplicationController
#     before_action :authenticate_request

#     def index
#         album = Album.all
#         render json: album
#     end


#     # Create album action
#     def create
#       album = @current_user.albums.new(album_params)
#       if album.save
#         render json: { message: 'Album created successfully' }, status: :created
#       else
#         render json: { error: album.errors.full_messages }, status: :unprocessable_entity
#       end
#     end
  
#     # Update album action
#     def update
#       album = Album.find(params[:id])
#       if album.update(album_params)
#         render json: { message: 'Album updated successfully' }
#       else
#         render json: { error: album.errors.full_messages }, status: :unprocessable_entity
#       end
#     end
  
#     private
  
#     def album_params
#       params.require(:album).permit(:title, :user_id)
#     end
  
# end
