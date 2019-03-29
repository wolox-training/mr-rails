require 'rails_helper'

RSpec.describe Rent, type: :model do
  subject(:rent) { build(:rent) }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of(:start_date) }
  it { is_expected.to validate_presence_of(:end_date) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:book) }
end
