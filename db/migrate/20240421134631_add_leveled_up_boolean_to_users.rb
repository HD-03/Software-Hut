class AddLeveledUpBooleanToUsers < ActiveRecord::Migration[7.0]
  def change
    #This column is needed to create the "pop-up" modal which congratulates students when they level up
    add_column :users, :recently_leveled_up, :boolean,        default: false, null: false
  end
end
