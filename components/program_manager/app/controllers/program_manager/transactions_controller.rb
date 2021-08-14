module ProgramManager
  class TransactionsController < ProgramManager::BaseApiController
    def index
      render json: Transaction.all
    end

    def show
      render json: Transaction.find(params[:id])
    end

    def authorizations
      customer = Customer.find(params[:customer_id])
      card = customer.cards.find(params[:card_id])

      render json: {
        customer: customer.as_json.merge(
          authorization_transactions: card.transactions.type_authorization.as_json
        )
      }
    end
  end
end
