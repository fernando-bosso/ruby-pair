class RenameTransactionsTypeToTransactionsTransactionType < ActiveRecord::Migration[6.1]
  def change
    rename_column :program_manager_transactions, :type, :transaction_type
  end
end
