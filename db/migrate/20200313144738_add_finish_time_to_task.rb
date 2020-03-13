class AddFinishTimeToTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :finish_time, :datetime, null: false
  end
end
