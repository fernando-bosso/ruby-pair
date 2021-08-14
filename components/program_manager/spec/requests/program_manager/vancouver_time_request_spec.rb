require 'rails_helper'

RSpec.describe '/api/vancouver_time_now', type: :request do
  subject(:get_time) { get "/api/vancouver_time_now" }

  before do
    stub_request(:get, "http://worldtimeapi.org/api/timezone/America/Vancouver")
      .to_return(body: "{\"datetime\":\"2021-08-12T15:02:45.584481-07:00\"}", status: 200)
  end

  it 'has status ok' do
    get_time

    expect(response).to have_http_status(:ok)
  end

  it 'renders time correctly' do
    get_time

    expect(response.body).to eq('2021-08-12T15:02:45.584481-07:00')
  end
end
