class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.references :guest, index: true
      t.string :code, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.integer :number_of_nights, default: 0
      t.integer :number_of_guests, default: 0
      t.integer :number_of_adults, default: 0
      t.integer :number_of_children, default: 0
      t.integer :number_of_infants, default: 0
      t.integer :payout_amount, default: 0
      t.integer :security_amount, default: 0
      t.integer :total_amount, default: 0
      t.string :currency
      t.integer :status, default: 0

      t.timestamps
    end
    add_index :reservations, :code, unique: true
    add_index :reservations, :start_date
    add_index :reservations, :end_date
    add_index :reservations, :status
  end
end
