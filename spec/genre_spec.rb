require_relative '../app/genre'
require_relative '../app/music_album'

describe Genre do
  context 'When testing Genre class' do
    before(:all) do
      @genre = Genre.new('Rock')
      @album = MusicAlbum.new(2020)
    end

    it 'The Genre class initialize correctly' do
      expect(@genre.name).to eq 'Rock'
    end

    it 'Add a new item to the Genre class and check association one to many with Item class' do
      @genre.add_item(@album)
      expect(@genre.items[0].publish_date).to eq 2020
      expect(@album.genre.name).to eq 'Rock'
    end
  end
end
