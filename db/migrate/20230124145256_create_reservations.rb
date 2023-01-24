class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.references :guest, foreign_key: true
      t.string :code
      t.datetime :start_date
      t.datetime :end_date
      t.integer :number_of_nights
      t.integer :number_of_guests
      t.integer :number_of_adults
      t.integer :number_of_children
      t.integer :number_of_infants
      t.text :status
      t.string :currency
      t.decimal :payout_price
      t.decimal :security_price
      t.decimal :total_price

      t.timestamps
    end
  end
end
