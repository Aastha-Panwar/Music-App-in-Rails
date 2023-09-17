class ApplicationController < ActionController::API
    include JsonWebToken
    # load_and_authorize_resource
    
    before_action :authenticate_request
    
    def not_found
        render json: { error: 'not_found' }
    end
    
    private
    #this function has responsibility for authorizing user requests
    
    def authenticate_request
        begin
            header = request.headers['Authorization']
            header = header.split(" ").last if header
            
            #decode JWT token and get user id
            decoded = jwt_decode(header)
            # byebug
            @current_user = User.find(decoded[:user_id])
        rescue JWT::DecodeError => e
            render json: { error: 'Invalid token' }
        rescue ActiveRecord::RecordNotFound
            render json: "No record found.."
        end
    end

    #for access denied in cancan gem  -- exception
    # rescue_from CanCan::AccessDenied do |exception|
    #     render json: exception.message
    # end
    
end
