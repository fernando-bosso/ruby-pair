require "rails_helper"

class SomeController < ProgramManager::BaseApiController
  def show
    raise ActiveRecord::RecordNotFound
  end
end

describe SomeController, type: :controller do
  before do
    Rails.application.routes.draw { match '/feature_test', to: 'some#show', via: :get }
  end

  after { Rails.application.reload_routes! }

  it 'renders not_found status' do
    get :show

    expect(response).to have_http_status(:not_found)
  end
end
