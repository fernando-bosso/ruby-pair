require 'rails_helper'

RSpec.describe '/api/transactions', type: :request do
  describe '.show' do
    subject(:show_transaction) { get "/api/transactions/#{transaction.id}" }

    let(:transaction) do
      ProgramManager::Transaction.create!(
        card_id: 1,
        transaction_type: 'authorization',
        currency: '$'
      )
    end

    it 'has status ok' do
      show_transaction

      expect(response).to have_http_status(:ok)
    end

    it 'returns transaction as json' do
      show_transaction

      expect(JSON.parse(response.body)).to match(transaction.as_json)
    end
  end

  describe '.index' do
    subject(:index_transactions) { get "/api/transactions/" }

    let(:first_transaction) do
      ProgramManager::Transaction.create!(
        amount: 321,
        card_id: 1,
        transaction_type: 'authorization',
        currency: '$'
      )
    end

    let(:second_transaction) do
      ProgramManager::Transaction.create!(
        amount: 123,
        card_id: 2,
        transaction_type: 'authorization',
        currency: '$'
      )
    end

    let!(:transactions) do
      [first_transaction, second_transaction]
    end

    it 'has status ok' do
      index_transactions

      expect(response).to have_http_status(:ok)
    end

    it 'returns transaction as json' do
      index_transactions

      expect(JSON.parse(response.body)).to match(transactions.as_json)
    end
  end
end
