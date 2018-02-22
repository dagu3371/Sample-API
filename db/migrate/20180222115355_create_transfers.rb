class CreateTransfers < ActiveRecord::Migration[5.0]
  def change
    create_table :transfers do |t|
      t.integer :user_id
      t.string :account_number_from
      t.string :account_number_to
      t.integer :amount_pennies
      t.string :country_code_from
      t.string :country_code_to

      t.timestamps
    end
  end
end
