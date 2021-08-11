module ProgramManager
  class TransactionsController < ActionController::API
    def index
      render json: Transaction.all
    end

    def show
      render json: Transaction.find(params[:id])
    end

    def authorizations
      customer = Customer.find(params[:customer_id])

      authorization_transactions =
        Transaction
          .type_authorization
          .where(customer_id: customer.id, card_id: params[:card_id])

      render json: {
        customer: customer.as_json.merge(
          authorization_transactions: authorization_transactions.as_json
        )
      }
    end
  end
end
