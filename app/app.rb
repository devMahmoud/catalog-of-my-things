require './music_album'
require './genre'
require 'json'
require './store_handlers.rb'

class App
  include Store
  attr_reader :books, :music, :games

  def initialize
    @books = []
    @games = []
    @genres = File.exist?('../data/genres.json') ? JSON.parse(File.read('../data/genres.json'), create_additions: true) : []
    @music = File.exist?('../data/music.json') ? genre_music : []
  end

  def list_all_books; end

  def list_all_music_albums
    music.each do |song|
      puts "[Author] : #{song.author} [Publish Date] : #{song.publish_date}  [Genre] : #{song.genre.name}"
    end
  end

  def list_of_games; end

  def list_all_genres
    select_filter = []
    puts "Please select for what item you want see the Genres? (book, music, game) : "
    selection = gets.chomp.downcase
    if selection == 'book'
      selection = 'Book'
    elsif selection == 'music'
      selection = 'MusicAlbum'
    elsif selection == 'game'
      selection == 'Game'
    else
      puts "Please select the correct option"
      list_all_genres
    end
    @genres.each do |genre|
      if genre.items[0].class.name == selection
        select_filter << genre
      end
    end
    select_filter.each do |genre|
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

  def save_data
    File.write('../data/music.json', JSON.pretty_generate(@music))
    File.write('../data/genres.json', JSON.pretty_generate(@genres))
  end
end
