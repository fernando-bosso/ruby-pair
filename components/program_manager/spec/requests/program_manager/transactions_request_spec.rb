require 'rails_helper'

RSpec.describe '/api/transactions', type: :request do
  describe '.show' do
    subject(:show_transaction) { get "/api/transactions/#{transaction.id}" }

    let(:transaction) { create(:transaction) }

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

    let!(:transactions) do
      create_list(:transaction, 2)
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

  describe '.authorizations' do
    subject(:show_authorization_transactions) do
      get "/api/customers/#{customer.id}/cards/#{card_id}/transactions/authorizations"
    end

    context 'when there are no authorization transactions' do
      let(:customer) { create(:customer, :with_card) }
      let(:card_id) { customer.cards.take.id }

      it 'has status ok' do
        show_authorization_transactions

        expect(response).to have_http_status :ok
      end

      it 'renders empty json array on authorization_transactions' do
        show_authorization_transactions

        parsed_response_body = JSON.parse(response.body)
        expect(parsed_response_body.dig('customer', 'authorization_transactions'))
          .to eq([])
      end
    end

    context 'when there are authorization transactions to display' do
      let(:customer) { create(:customer, :with_authorization_transactions) }
      let(:card_id) { customer.cards.first.id }
      let!(:authorization_transaction_list) do
        create_list(:transaction, 2, transaction_type: :authorization, customer: customer)
      end
      let!(:not_authorization_transaction) do
        create(:transaction, transaction_type: :refund, customer: customer)
      end
      let!(:another_customer_transaction) do
        create(:transaction, transaction_type: :authorization)
      end
      let!(:authorization_from_customer_another_card) do
        create(:transaction, transaction_type: :authorization, customer: customer, card: create(:card))
      end

      it 'has status ok' do
        show_authorization_transactions

        expect(response).to have_http_status(:ok)
      end

      it 'renders the customer' do
        show_authorization_transactions

        expect(JSON.parse(response.body)).to include(
          'customer' => a_hash_including(
            'id' => customer.id,
            'first_name' => customer.first_name,
            'last_name' => customer.last_name,
            'created_at' => customer.created_at.as_json,
            'updated_at' => customer.updated_at.as_json
          )
        )
      end

      it 'renders the authorization transactions of that customer' do
        show_authorization_transactions

        parsed_response_body = JSON.parse(response.body)
        authorization_transaction =
          parsed_response_body.dig('customer', 'authorization_transactions').first

        expect(parsed_response_body['customer']).to have_key('authorization_transactions')
        expect(authorization_transaction.keys).to include(
          'amount', 'card_id', 'created_at', 'currency', 'customer_id',
          'parent_transaction_id', 'transaction_type', 'updated_at'
        )
      end

      it 'does not renders not authorization transactions of that customer or of another customer' do
        show_authorization_transactions

        parsed_response_body = JSON.parse(response.body, symbolize_names: true)
        rendered_transactions = parsed_response_body.dig(:customer, :authorization_transactions)
        rendered_transaction_transaction_types = rendered_transactions.map { |rt| rt[:transaction_type] }
        rendered_transaction_customer_id = rendered_transactions.map { |rt| rt[:customer_id] }
        rendered_transaction_card_id = rendered_transactions.map { |rt| rt[:card_id] }

        expect(rendered_transaction_transaction_types).to all eq('authorization')
        expect(rendered_transaction_customer_id).to all eq(customer.id)
        expect(rendered_transaction_card_id).to all eq(card_id)
      end
    end
  end
end
