require "rails_helper"

RSpec.describe Book, type: :model do
  let(:invalid_book) { build(:book, :empty_title) }
  let!(:book) { create(:book, :with_cover, :with_content) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:author) }
  it { is_expected.to validate_presence_of(:isbn) }

  it "is not valid with an empty title" do
    expect(invalid_book).not_to be_valid
  end
  
  it "is expected to have attached cover and content" do
    expect(book.cover).to be_attached
    expect(book.content).to be_attached
  end
end
