class Tag < ApplicationRecord
    has_many :taggings
    has_many :taks, through: :taggings
  
    validates :title, uniqueness: true
end
