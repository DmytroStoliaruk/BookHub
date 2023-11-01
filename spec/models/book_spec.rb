require "rails_helper"

RSpec.describe Book, type: :model do
  let(:invalid_book) { build(:book, :empty_title) }

  it "is not valid with an empty title" do
    expect(invalid_book).not_to be_valid
  end
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:author) }
  it { is_expected.to validate_presence_of(:isbn) }

end
