require 'rails_helper'

RSpec.describe BookSearch do
  let!(:book1) { create(:book, :search_params1) }
  let!(:book2) { create(:book, :search_params2) }
  
  subject { BookSearch.search(query) }
  
  before(:each) do
    BooksIndex.reset
  end
  
  describe '.search' do
    context "when searching for 'number'" do
      let(:query) { "number" }

      it 'returns books matching the query' do
        expect(subject).to match_array([book1, book2])
      end
    end

    context "when searching for 'Adams'" do
      let(:query) { "Adams" }

      it "returns books with the author 'Adams'" do      
        expect(subject).to include(book2)
      end
    end

    context "when searching for 'About'" do
      let(:query) { "About" }

      it "returns books with the description 'About'" do
        expect(subject).to match_array([book1, book2])
      end
    end

    context "when searching with wrong parameters" do
      let(:query) { "Some title" }

      it "returns no books" do         
        expect(subject).to be_empty
      end
    end
  end
end
