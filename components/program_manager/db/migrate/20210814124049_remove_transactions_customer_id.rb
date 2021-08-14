class RemoveTransactionsCustomerId < ActiveRecord::Migration[6.1]
  def change
    remove_column :program_manager_transactions, :customer_id
  end
end
