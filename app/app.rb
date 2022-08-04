require './music_album'
require './genre'
require './book'
require 'json'

class App
  attr_reader :books, :music, :games

  def initialize
    @books = File.exist?('../data/books.json') ? JSON.parse(File.read('../data/books.json'), create_additions: true) : []
    @music = []
    @games = []
    @genres = []
  end

  def list_all_books
    p books
    books.each do |book|
      puts "Title: #{book.label}  Author: #{book.author}"
    end
    puts
  end

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

  def add_book
    print 'Cover State [good/bad]: '
    cover_state = gets.chomp
    print 'Publish Date (year only): '
    publish_date = gets.chomp.to_i
    print 'Publisher: '
    publisher = gets.chomp
    book = Book.new(publisher, cover_state, publish_date)
    print 'Book Title: '
    book.label = gets.chomp
    print 'Author Name: '
    book.add_author gets.chomp
    print "Genre (e.g 'Comedy', 'Thriller'): "
    book.add_genre gets.chomp
    print "Source (e.g. 'From a friend', 'Online shop'): "
    book.add_source gets.chomp
    @books.push(book)
    puts 'Book created successfully'
    puts
  end

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

  def save_data
    File.write('../data/books.json', JSON.pretty_generate(@books))
  end

  def add_game; end
end
