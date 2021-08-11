# frozen_string_literal: true

FactoryBot.define do
  factory :customer, class: "ProgramManager::Customer" do
    first_name { Faker::Name.first_name }
  end
end
