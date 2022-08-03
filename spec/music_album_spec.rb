require_relative '../app/music_album'

describe MusicAlbum do
  context 'When testing the MusicAlbum class' do
    before(:all) do
      @album = MusicAlbum.new(2000)
    end

    it 'The class initialized correctly' do
      expect(@album.publish_date).to eq 2000
      expect(@album.on_spotify).to be_falsey
    end

    it 'the album move to archive or not' do
      # Return false if not listed in spotify
      @album.move_to_archive
      expect(@album.archived).to be false

      # Return true if listed in spotify
      @album.on_spotify = true
      @album.move_to_archive
      expect(@album.archived).to be true
    end
  end
end
