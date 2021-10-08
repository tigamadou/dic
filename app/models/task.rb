class Task < ApplicationRecord
    validates :name, presence: true
    validates :status, presence: true

    enum status_type: [:not_set, :unstarted, :in_progress, :completed]
    enum priority_type: [:low, :medium, :hight]
    paginates_per 50
    
    belongs_to :user

    has_many :taggings, dependent: :destroy
    has_many :tags, through: :taggings

    def self.search(query)
        where('name LIKE :query',query: "%#{query}%") 
    end

    def self.filter_by_status(status)
        where('status LIKE :status', status: "%#{status}%") 
    end

    def self.order_by_deadline
        order("expired_at DESC")
    end

    def self.order_by_priority
        order("priority DESC")
    end
end
