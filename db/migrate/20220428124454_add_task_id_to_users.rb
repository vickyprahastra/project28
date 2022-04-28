class AddTaskIdToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :task_id, :string, default: nil
  end
end
