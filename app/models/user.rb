class User < ActiveRecord::Base
    scope :get_user_by_email, -> (email) { where("email = ?", email)}
    has_secure_password
    has_many :articles
    validates_uniqueness_of :email
    validates :name, presence: true
    validates :email, presence: true
    
end