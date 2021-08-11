module ProgramManager
  class Transaction < ActiveRecord::Base
    self.table_name = "program_manager_transactions"

    belongs_to :card
    belongs_to :customer
  end
end
