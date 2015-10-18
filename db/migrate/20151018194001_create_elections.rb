class CreateElections < ActiveRecord::Migration
  def change
    create_table :elections do |t|
      t.string :name
      t.references :owner, index: true
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps null: false
    end
  end
end
