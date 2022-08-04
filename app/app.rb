require './music_album'
require './genre'
require './author'
require 'json'
require './handlers'

class App
  include Handlers
  attr_reader :books, :music, :games

  def initialize
    @books = []
    @games = []
    @authors = File.exist?('../data/authors.json') ? authors_store : []
    @genres = File.exist?('../data/genres.json') ? genre_store : []
    @music = File.exist?('../data/music.json') ? genre_music : []
  end

  def list_all_books; end

  def list_all_music_albums
    @music.each do |song|
      puts "[Author] : #{song.author.first_name} [Publish Date] : #{song.publish_date}  [Genre] : #{song.genre.name}"
    end
  end

  def list_of_games; end

  # rubocop:disable Style/ClassEqualityComparison
  def list_all_genres
      puts "[Genre] : #{genre.name}"
  end

  # rubocop:enable Style/ClassEqualityComparison
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
    album = MusicAlbum.new(date, spotify: on_spotify)
    @authors.empty? ? if_author_empty(author_input, album) : if_has_author(@authors, author_input, album)
    @genres.empty? ? if_genre_empty(genre_input, album) : if_has_genre(@genres, genre_input, album)
    music << album
  end

  def add_game; end

  def save_data
    File.write('../data/authors.json', JSON.pretty_generate(@authors))
    File.write('../data/genres.json', JSON.pretty_generate(@genres))
    File.write('../data/music.json', JSON.pretty_generate(@music))
  end
end
