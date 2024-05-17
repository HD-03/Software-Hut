class CreateBasetenRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :baseten_requests do |t|
      t.string :request_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
