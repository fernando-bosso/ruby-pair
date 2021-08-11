# frozen_string_literal: true

FactoryBot.define do
  factory :customer, class: "ProgramManager::Customer" do
    first_name { Faker::Name.first_name }

    trait :with_card do
      cards { [association(:card)] }
    end

    trait :with_authorization_transactions do
      with_card

      after(:create) do |customer, evaluator|
        customer.transactions << create_list(:transaction,
                                             2,
                                             transaction_type: 'authorization',
                                             card: customer.cards.take)
      end
    end
  end
end
