# frozen_string_literal: true

require "rails_helper"

RSpec.describe Book, type: :model do
  # create object for testing
  subject { described_class.new(title: "Test Book", author: "Test Author", isbn: "123-12345-123-1234") }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a title" do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without an author" do
    subject.author = nil
    expect(subject).to_not be_valid
  end
end
