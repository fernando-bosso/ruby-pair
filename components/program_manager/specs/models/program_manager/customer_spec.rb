require "rails_helper"

RSpec.describe ProgramManager::Customer, type: :model do
  subject(:customer) { build(:customer) }

  it { is_expected.to have_many(:cards).dependent(:restrict_with_error) }
  it { is_expected.to have_many(:transactions).dependent(:restrict_with_error) }
end
