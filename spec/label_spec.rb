require_relative '../app/label'

describe Label do
  context 'When testing label class' do
    before(:all) do
      @label = Label.new('Game Of Thrones', 'Red')
    end

    it 'The label class initialize correctly' do
      expect(@label.title).to eq 'Game Of Thrones'
      expect(@label.color).to eq 'Red'
    end

    it 'Add item correctly' do
      book = Book.new('Mahmoud', 'bad', 2020)
      @label.add_item(book)
      expect(@label.items.length).to eq 1
      expect(book.label).to eq @label
    end
  end
end
