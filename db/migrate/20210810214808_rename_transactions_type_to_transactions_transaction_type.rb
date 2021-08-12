class RenameTransactionsTypeToTransactionsTransactionType < ActiveRecord::Migration[6.1]
  def change
    # In a production environment with several records, this might be dangerous
    rename_column :program_manager_transactions, :type, :transaction_type
  end
end
