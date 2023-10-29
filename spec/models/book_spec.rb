require "rails_helper"

RSpec.describe Book, type: :model do
  let(:valid_book) { create(:book) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:author) }
  it { is_expected.to validate_presence_of(:isbn) }
end
