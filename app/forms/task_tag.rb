class TaskTag

    include ActiveModel::Model
    attr_accessor :name, :content, :expired_at, :status,:priority, :user_id
  
    with_options presence: true do
      validates :name
      validates :status
    end
  
    def save
      task = Task.create(name: name, content: content, expired_at: expired_at, status: status, priority: priority, user_id: user_id)
      
      tag = Tag.where(name: name).first_or_initialize
      tag.save
      PostTagRelation.create(post_id: post.id, tag_id: tag.id)
    end
  end