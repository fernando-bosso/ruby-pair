require "rails_helper"

RSpec.describe TimeClient do
  describe '.get_time' do
    subject(:get_time) { described_class.time_at(timezone_name) }

    context 'when timezone format is correct' do
      let(:timezone_name) { 'America/Vancouver' }

      before do
        stub_request(:get, "http://worldtimeapi.org/api/timezone/America/Vancouver")
          .to_return(
            body: "{\"abbreviation\":\"PDT\",\"client_ip\":\"186.193.137.78\",\
                  \"datetime\":\"2021-08-12T15:02:45.584481-07:00\",\"day_of_week\":4,\
                  \"day_of_year\":224,\"dst\":true,\"dst_from\":\"2021-03-14T10:00:00+00:00\",\
                  \"dst_offset\":3600,\"dst_until\":\"2021-11-07T09:00:00+00:00\",\
                  \"raw_offset\":-28800,\"timezone\":\"America/Vancouver\",\
                  \"unixtime\":1628805765,\"utc_datetime\":\"2021-08-12T22:02:45.584481+00:00\",\
                  \"utc_offset\":\"-07:00\",\"week_number\":32}",
            status: 200
          )
      end

      it 'returns time in chosen timezone' do
        expect(get_time).to eq('2021-08-12T15:02:45.584481-07:00')
      end
    end

    context 'when timezone format is incorrect' do
      let(:timezone_name) {  'Foo/Bar' }

      before do
        stub_request(:get, "http://worldtimeapi.org/api/timezone/Foo/Bar")
          .to_return(
            body: "{\"error\":\"unknown location\"}",
            status: 200
          )
      end

      it 'returns time in chosen timezone' do
        expect(get_time).to eq('unknown location')
      end
    end
  end
end
