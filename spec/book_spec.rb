require_relative '../app/book'

describe Book do
  context 'When testing book class' do
    before(:all) do
      @book = Book.new('Mahmoud', 'bad', 2020)
    end

    it 'The book class initialize correctly' do
      expect(@book.publisher).to eq 'Mahmoud'
      expect(@book.cover_state).to eq 'bad'
      expect(@book.publish_date).to eq 2020
    end

    it 'Check if the book can_be_archived' do
      expect(@book.send(:can_be_archived?)).to be true
      @book.cover_state = 'good'
      expect(@book.send(:can_be_archived?)).to be false
    end
  end
end
