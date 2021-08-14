module ProgramManager
  class VancouverTimeController < ProgramManager::BaseApiController
    def now
      render json: TimeClient.time_at('America/Vancouver')
    end
  end
end
