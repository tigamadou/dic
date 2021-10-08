class Tag < ApplicationRecord
    has_many :taggings
    has_many :taks, through: :taggings
  
    validates :title, presence: true, uniqueness: true
end
