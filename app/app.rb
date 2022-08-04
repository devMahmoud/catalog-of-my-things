require './music_album'
require './genre'
require './author'
require './book'
require './label'
require 'json'
require './handlers'

class App
  attr_reader :books, :music, :games, :genres, :labels

  include Handlers

  def initialize
    @authors = File.exist?('../data/authors.json') ? authors_store : []
    @genres = File.exist?('../data/genres.json') ? genre_store : []
    @music = File.exist?('../data/music.json') ? genre_music : []
    @books = if File.exist?('../data/books.json')
               JSON.parse(File.read('../data/books.json'),
                          create_additions: true)
             else
               []
             end
    @games = []
    @labels = if File.exist?('../data/labels.json')
                JSON.parse(File.read('../data/labels.json'),
                           create_additions: true)
              else
                []
              end
  end

  def list_all_books
    books.each do |book|
      puts "Title: #{book.label.title}  Author: #{book.author} Genre: #{book.genre}"
    end
    puts
  end

  def list_all_music_albums
    @music.each do |song|
      puts "[Author] : #{song.author.first_name} [Publish Date] : #{song.publish_date}  [Genre] : #{song.genre.name}"
    end
  end

  def list_of_games; end

  def list_all_genres
    @genres.each do |genre|
      puts "[Genre] : #{genre.name}"
    end
  end

  def list_all_labels
    @labels.each do |label|
      puts "[Label] : #{label.title}"
    end
  end

  def list_all_authors
    @authors.each do |author|
      puts "[Author] : #{author.first_name}"
    end
  end

  # rubocop:disable Metrics/MethodLength
  def add_book
    print 'Book Title: '
    title = gets.chomp
    print 'Cover State [good/bad]: '
    cover_state = gets.chomp
    print 'Publish Date (year only): '
    publish_date = gets.chomp.to_i
    print 'Publisher: '
    publisher = gets.chomp
    label = Label.new(title)
    print 'Author Name: '
    author = gets.chomp
    print "Source (e.g. 'From a friend', 'Online shop'): "
    source = gets.chomp
    print "Genre (e.g 'Comedy', 'Thriller'): "
    genre = Genre.new(gets.chomp)
    book = Book.new(
      publisher,
      cover_state,
      publish_date,
      label.title,
      author,
      source,
      genre.name
    )
    label.add_item(book)
    labels.push(label)
    genres.push(genre)
    @books.push(book)
    puts 'Book created successfully'
    puts
  end
  # rubocop:enable Metrics/MethodLength

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

  def save_data
    File.write('../data/books.json', JSON.pretty_generate(@books))
    File.write('../data/labels.json', JSON.pretty_generate(@labels))
    File.write('../data/authors.json', JSON.pretty_generate(@authors))
    File.write('../data/genres.json', JSON.pretty_generate(@genres))
    File.write('../data/music.json', JSON.pretty_generate(@music))
  end

  def add_game; end
end
