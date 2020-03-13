class ChangeColumnType < ActiveRecord::Migration[6.0]
  def change
    change_column :tasks, :name, :string, :null => false, :default => ""
    change_column :tasks, :content, :string, :null => false, :default => ""
  end
end
