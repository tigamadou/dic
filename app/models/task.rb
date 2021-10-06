class Task < ApplicationRecord
    validates :name, presence: true
    validates :content, presence: true

    enum status_type: [:not_set, :unstarted, :in_progress, :completed]

    def self.search(query)
        where('name LIKE :query',query: "%#{query}%") 
    end

    def self.filter_by_status(status)
        where('status LIKE :status', status: "%#{status}%") 
    end

    def self.filter_by_deadline

    end
end
