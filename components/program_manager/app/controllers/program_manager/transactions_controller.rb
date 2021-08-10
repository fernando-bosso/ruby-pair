module ProgramManager
  class TransactionsController < ActionController::API
    def index
      render json: Transaction.all
    end

    def show
      render json: Transaction.find(params[:id])
    end
  end
end
