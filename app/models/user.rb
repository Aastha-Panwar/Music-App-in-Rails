class User < ApplicationRecord
    has_secure_password
    # STI inheritance
    self.inheritance_column = :user_type
    has_many :recently_playeds, dependent: :destroy
    has_many :recommended_tracks, dependent: :destroy  
    
    # Validations
    validates :email, presence: true
    validates :password, presence: true, length: { minimum: 8 }
    validates :user_type, presence: true, inclusion: { in: ['Listener', 'Artist'] }
end
