class RenameDeadlineColumn < ActiveRecord::Migration[5.2]
  def up
    rename_column :tasks, :deadline, :expired_at
  end

  def down
    
  end
end
