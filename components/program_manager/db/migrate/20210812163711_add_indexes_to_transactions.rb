class AddIndexesToTransactions < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    change_table :program_manager_transactions do |t|
      # As PostgreSQL manages to combine indexes, I didn't feel the need to add
      # composite indexes
      t.index :customer_id
      t.index :card_id
      t.index :transaction_type
    end
  end
end
