require './music_album'
require './genre'

class App
  attr_reader :books, :music, :games

  def initialize
    @books = []
    @music = []
    @games = []
    @genres = []
  end

  def list_all_books; end

  def list_all_music_albums
    music.each do |song|
      puts "[Author] : #{song.author} [Publish Date] : #{song.publish_date}  [Genre] : #{song.genre.name}"
    end
  end

  def list_of_games; end

  def list_all_genres
    @genres.each do |genre|
      puts "[Genre] : #{genre.name}"
    end
  end

  def list_all_labels; end

  def list_all_authors; end

  def add_book; end

  def add_music_album
    print 'Please enter the author: '
    author_input = gets.chomp.capitalize
    print 'Please enter the date: '
    date = gets.chomp.to_i
    print 'Is listed in spotify? (y/n): '
    spotify_ask = gets.chomp
    on_spotify = spotify_ask == 'y'
    print 'What is the genre (e.g Rock, Pop... etc) : '
    genre_input = gets.chomp.capitalize
    genre = Genre.new(genre_input)
    album = MusicAlbum.new(date, spotify: on_spotify)
    album.add_author(author_input)
    genre.add_item(album)
    @genres << genre unless @genres.include? genre
    music << album
  end

  def add_game; end
end
