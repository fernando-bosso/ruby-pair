module ProgramManager
  class Customer < ActiveRecord::Base
    self.table_name = "program_manager_customers"

    has_many :cards, dependent: :restrict_with_error
    has_many :transactions, through: :cards
  end
end
