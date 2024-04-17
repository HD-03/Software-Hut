class ChangeXpNeededDefaultValue < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :xp_needed_for_next_level, from: 0, to: 30
  end
end
