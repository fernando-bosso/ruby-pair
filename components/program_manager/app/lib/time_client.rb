module TimeClient
  class << self
    def time_at(timezone)
      response = Net::HTTP.get(URI("http://worldtimeapi.org/api/timezone/#{timezone}"))

      parsed_response = JSON.parse(response, symbolize_names: true)

      parsed_response[:datetime] || parsed_response[:error]
    end
  end
end
