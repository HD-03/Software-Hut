class AddGenerationRightToUsers < ActiveRecord::Migration[7.0]
  # column that regulates the number of generations available to the user (student)
  def change
    add_column :users, :has_right_to_generate_avatar, :integer, default: 0, null: false
  end
end
