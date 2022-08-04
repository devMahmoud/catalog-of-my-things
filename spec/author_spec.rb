require_relative '../app/author'
require_relative '../app/game'

describe Author do
  context 'When testing Author class' do
    before(:all) do
      @author = Author.new('J.K', 'Rowling')
      @game = Game.new('yes', 2021, 2000)
    end

    it 'The Author class initialize correctly' do
      expect(@author.first_name).to eq 'J.K'
      expect(@author.last_name).to eq 'Rowling'
    end

    it 'Add a new item to the Author class and check association one to many with Item class' do
      @author.add_item(@game)
      expect(@author.items[0].publish_date).to eq 2000
      expect(@game.author).to eq @author
    end
  end
end
