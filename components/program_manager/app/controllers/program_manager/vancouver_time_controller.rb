module ProgramManager
  class VancouverTimeController < ActionController::API
    def now
      render json: TimeClient.time_at('America/Vancouver')
    end
  end
end
