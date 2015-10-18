class CreateElections < ActiveRecord::Migration
  def change
    create_table :elections do |t|
      t.string :name
      t.datetime :start_at
      t.datetime :end_at
      t.references :user, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
