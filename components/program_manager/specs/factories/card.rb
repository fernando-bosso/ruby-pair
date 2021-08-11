# frozen_string_literal: true

FactoryBot.define do
  factory :card, class: "ProgramManager::Card" do
    customer
  end
end
