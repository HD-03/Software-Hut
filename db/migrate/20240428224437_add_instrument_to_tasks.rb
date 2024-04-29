class AddInstrumentToTasks < ActiveRecord::Migration[7.0]
  def up
    piano = Instrument.find_or_create_by(name: "Piano")
    add_reference :tasks, :instrument, null: false, foreign_key: true, default: piano.id
  end

  def down
    remove_reference :tasks, :instrument, foreign_key: true
  end
end
