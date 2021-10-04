class AddConstraintToTask < ActiveRecord::Migration[5.2]
  def up
    change_column :tasks, :name, :string, null: false
    change_column :tasks, :status, :string, null: false

  end

  def down
    change_column :tasks, :name, :string, null: true
    change_column :tasks, :status, :string, null: true
  end
end
