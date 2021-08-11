# frozen_string_literal: true

FactoryBot.define do
  factory :transaction, class: "ProgramManager::Transaction" do
    card
    customer
  end
end
