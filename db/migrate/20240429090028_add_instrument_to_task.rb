class AddInstrumentToTask < ActiveRecord::Migration[7.0]
  def change
    
    add_reference :tasks, :instrument, null: false, foreign_key: true, default: 1
  end
end