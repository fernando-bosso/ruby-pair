# frozen_string_literal: true

FactoryBot.define do
  factory :transaction, class: "ProgramManager::Transaction" do
    card

    currency { '$' }
    transaction_type { 'authorization' }
  end
end
