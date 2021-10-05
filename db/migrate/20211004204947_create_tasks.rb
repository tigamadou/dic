class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :content
      t.datetime :deadline
      t.string :status

      t.timestamps
    end
  end
end
