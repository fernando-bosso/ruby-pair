require "rails_helper"

RSpec.describe ProgramManager::Transaction, type: :model do
  subject(:transaction) { build(:transaction) }

  it { is_expected.to belong_to(:card) }
  it { is_expected.to have_one(:customer).through(:card) }
  it { is_expected.to belong_to(:parent_transaction).optional }
  it { is_expected.to have_many(:child_transactions).dependent(:restrict_with_error) }
end
