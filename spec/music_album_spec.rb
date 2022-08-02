require_relative '../app/music_album'

describe MusicAlbum do
  context 'When testing the MusicAlbum class' do
    before(:all) do
      @album = MusicAlbum.new(2020)
    end

    it 'The class initialized correctly' do
      expect(@album.publish_date).to eq 2020
      expect(@album.on_spotify).to be_falsey
    end
  end
end
