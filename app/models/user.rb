class User < ApplicationRecord
    attr_accessor :skip_validations
    before_validation { email.downcase! if email}
    has_secure_password
    validates :name,  presence: true, length: { maximum: 30 }
    validates :email, presence: true, length: { maximum: 255 },
            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
    validates :password, length: { minimum: 6 }, unless: :skip_validations
    has_many :tasks,  dependent: :destroy 

    enum role_type: [:default, :admin]

    def self.get_admins
        where(role: 'admin') 
    end
end
