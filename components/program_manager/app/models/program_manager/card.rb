module ProgramManager
  class Card < ActiveRecord::Base
    self.table_name = "program_manager_cards"

    belongs_to :customer

    has_many :transactions, dependent: :restrict_with_error
  end
end
