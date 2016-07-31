class CreateDistanceAndTimes < ActiveRecord::Migration
  def change
    create_table :distance_and_times do |t|
      t.integer :start_id
      t.integer :end_id
      t.integer :cost_time
      t.integer :distance

      t.timestamps null: false
    end
    add_index :distance_and_times, :start_id
    add_index :distance_and_times, :end_id
    add_index :distance_and_times, [:start_id, :end_id], unique: true
  end
end
