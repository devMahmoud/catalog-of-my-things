require './music_album'
require './genre'
require './book'
require './label'
require 'json'

class App
  attr_reader :books, :music, :games, :genres, :labels

  def initialize
    @books = if File.exist?('../data/books.json')
               JSON.parse(File.read('../data/books.json'),
                          create_additions: true)
             else
               []
             end
    @music = []
    @games = []
    @genres = []
    @labels = if File.exist?('../data/labels.json')
                JSON.parse(File.read('../data/labels.json'),
                           create_additions: true)
              else
                []
              end
  end

  def list_all_books
    p books
    books.each do |book|
      puts "Title: #{book.label.title}  Author: #{book.author} Genre: #{book.genre}"
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

  def list_all_labels
    @labels.each do |label|
      puts "[Label] : #{label.title}"
    end
  end

  def list_all_authors; end

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
    genre = Genre.new(genre_input)
    album = MusicAlbum.new(date, spotify: on_spotify)
    album.add_author(author_input)
    genre.add_item(album)
    @genres << genre unless @genres.include? genre
    music << album
  end

  def save_data
    File.write('../data/books.json', JSON.pretty_generate(@books))
    File.write('../data/labels.json', JSON.pretty_generate(@labels))
  end

  def add_game; end
end
