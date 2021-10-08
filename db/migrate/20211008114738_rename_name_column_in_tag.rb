class RenameNameColumnInTag < ActiveRecord::Migration[5.2]
  def change
    rename_column :tags, :name, :title
  end
  
end
