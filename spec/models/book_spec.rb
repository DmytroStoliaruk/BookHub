# frozen_string_literal: true

require "rails_helper"

RSpec.describe Book, type: :model do

  let(:valid_book) { create(:book) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:author) }
  it { should validate_presence_of(:isbn) }
  
  it "is valid with valid attributes" do
    expect(valid_book).to be_valid
  end

end
