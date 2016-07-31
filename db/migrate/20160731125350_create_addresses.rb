class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :place
      t.decimal :longitude
      t.decimal :latitude

      t.timestamps null: false
    end
    add_index :addresses, :place, unique: true
  end
end
