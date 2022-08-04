require './music_album'
require './genre'
require './author'
require './book'
require './game'
require './label'
require 'json'
require './handlers'

# rubocop:disable Metrics/ClassLength
class App
  attr_reader :books, :music, :games, :genres, :labels, :authors

  include Handlers

  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/PerceivedComplexity
  def initialize
    @authors = File.exist?('../data/authors.json') ? authors_store : []
    @genres = File.exist?('../data/genres.json') ? genre_store : []
    @labels = if File.exist?('../data/labels.json')
                JSON.parse(File.read('../data/labels.json'),
                           create_additions: true)
              else
                []
              end
    @music = File.exist?('../data/music.json') ? genre_music : []
    @books = if File.exist?('../data/books.json')
               JSON.parse(File.read('../data/books.json'),
                          create_additions: true)
             else
               []
             end
    @games = if File.exist?('../data/games.json')
               JSON.parse(File.read('../data/games.json'),
                          create_additions: true)
             else
               []
             end
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/PerceivedComplexity

  def list_all_books
    books.each do |book|
      puts "Title: #{book.label.title}  Author: #{book.author} Genre: #{book.genre}"
    end
    puts
  end

  def list_all_music_albums
    @music.each do |song|
      puts "[Author] : #{song.author.first_name} [Title] : #{song.label.title} [Date] : #{song.publish_date}"
    end
  end

  def list_of_games
    games.each do |game|
      puts "Title: #{game.label.title}  Multiplayer: #{game.multiplayer} Genre: #{game.genre.name}"
    end
    puts
  end

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
    author_input = gets.chomp
    author_arr = author_input.split
    print "Source (e.g. 'From a friend', 'Online shop'): "
    source = gets.chomp
    print "Genre (e.g 'Comedy', 'Thriller'): "
    genre = Genre.new(gets.chomp)
    author = Author.new(author_arr[0], author_arr[1])
    book = Book.new(
      publisher,
      cover_state,
      publish_date,
      label.title,
      author_input,
      source,
      genre.name
    )
    author.add_item(book)
    label.add_item(book)
    authors.push(author)
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
    print 'Please enter the title of the album: '
    label_input = gets.chomp.capitalize
    print 'Please enter the date (year): '
    date = gets.chomp.to_i
    print 'Is listed in spotify? (y/n): '
    spotify_ask = gets.chomp
    on_spotify = spotify_ask == 'y'
    print 'What is the genre (e.g Rock, Pop... etc) : '
    genre_input = gets.chomp.capitalize
    album = MusicAlbum.new(date, spotify: on_spotify)
    @authors.empty? ? if_author_empty(author_input, album) : if_has_author(@authors, author_input, album)
    @genres.empty? ? if_genre_empty(genre_input, album) : if_has_genre(@genres, genre_input, album)
    @labels.empty? ? if_label_empty(label_input, album) : if_has_label(@labels, label_input, album)
    music << album
  end

  # rubocop:disable Metrics/MethodLength
  def add_game
    print 'Game Name: '
    title = gets.chomp
    print 'Is it a multiplayer game? [y/n]: '
    multiplayer = %w[y Y Yes yes].include? gets.chomp ? true : false
    print 'Publish Date (year only): '
    publish_date = gets.chomp.to_i
    print 'Last play at (year only): '
    last_play_at = gets.chomp.to_i
    label = Label.new(title)
    print 'Author Name: '
    author_input = gets.chomp
    author_arr = author_input.split
    author = Author.new(author_arr[0], author_arr[1])
    print "Source (e.g. 'From a friend', 'Online shop'): "
    source = gets.chomp
    print "Genre (e.g 'Comedy', 'Thriller'): "
    genre = Genre.new(gets.chomp)
    game = Game.new(
      multiplayer,
      last_play_at,
      publish_date,
      label.title,
      author_input,
      source,
      genre.name
    )
    author.add_item(game)
    label.add_item(game)
    genre.add_item(game)
    authors.push(author)
    labels.push(label)
    genres.push(genre)
    @games.push(game)
    puts 'Game created successfully'
    puts
  end
  # rubocop:enable Metrics/MethodLength

  def save_data
    File.write('../data/books.json', JSON.pretty_generate(@books))
    File.write('../data/games.json', JSON.pretty_generate(@games))
    File.write('../data/labels.json', JSON.pretty_generate(@labels))
    File.write('../data/authors.json', JSON.pretty_generate(@authors))
    File.write('../data/genres.json', JSON.pretty_generate(@genres))
    File.write('../data/music.json', JSON.pretty_generate(@music))
  end
end
# rubocop:enable Metrics/ClassLength
