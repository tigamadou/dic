class AddPriorityColumnToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :priority, :string, default: 'low'
  end
end
