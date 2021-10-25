class CreateGuests < ActiveRecord::Migration[6.0]
  def change
    create_table :guests do |t|
      t.string :email, null: false
      t.text :phone
      t.string :first_name
      t.string :last_name
      t.timestamps
    end
    add_index :guests, :email, unique: true
  end
end
