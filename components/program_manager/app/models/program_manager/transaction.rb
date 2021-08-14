module ProgramManager
  class Transaction < ActiveRecord::Base
    self.table_name = 'program_manager_transactions'

    belongs_to :card
    belongs_to :parent_transaction,
               optional: true,
               class_name: 'Transaction',
               foreign_key: 'parent_transaction_id'

    has_one :customer, through: :card

    has_many :child_transactions,
             dependent: :restrict_with_error,
             class_name: 'Transaction',
             foreign_key: 'parent_transaction_id'

    scope :type_authorization, -> { where(transaction_type: 'authorization') }

    enum transaction_type: {
      authorization: 'authorization',
      capture: 'capture',
      refund: 'refund',
      purchase: 'purchase'
    }
  end
end
