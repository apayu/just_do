class AddStateToTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :state, :string, null: false
  end
end
