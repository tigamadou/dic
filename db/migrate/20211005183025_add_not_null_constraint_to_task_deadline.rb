require "time"

class AddNotNullConstraintToTaskDeadline < ActiveRecord::Migration[5.2]
  def up
    change_column :tasks, :expired_at, :datetime, null: false, default: Time.now

  end

  def down
    
  end
end
