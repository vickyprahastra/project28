class AddLastBirthdayToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :last_birthday, :datetime
  end
end
