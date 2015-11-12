class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :card_owner_id
      t.string :cardnumber
      t.string :cardtype
      t.integer :expmonth
      t.integer :expyear
      t.decimal :balance

      t.timestamps null: false
    end
  end
end
