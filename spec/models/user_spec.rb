require "rails_helper"

RSpec.describe User, type: :model do
  let(:invalid_user) { build :user, :empty_first_name }
  let!(:user) { create :user }

  it "is not valid with an empty first_name" do
    expect(invalid_user).not_to be_valid
  end

  it "is valid with valid params" do
    expect(user).to be_valid
  end

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_presence_of(:password) }
end
