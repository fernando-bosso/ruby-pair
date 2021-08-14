require "rails_helper"

RSpec.describe ProgramManager::Card, type: :model do
  subject(:card) { build(:card) }

  it { is_expected.to belong_to(:customer) }
  it { is_expected.to have_many(:transactions).dependent(:restrict_with_error) }
end
