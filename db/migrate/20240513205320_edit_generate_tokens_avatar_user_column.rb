class EditGenerateTokensAvatarUserColumn < ActiveRecord::Migration[7.0]
  def change
    change_column_default(:users, :has_right_to_generate_avatar, '1')
    rename_column :users, :has_right_to_generate_avatar, :generate_tokens
  end
end
