require './app'

class Main
  attr_reader :app

  def initialize
    puts 'Welcome to School Library App!'
    @app = App.new
    show_menu
  end

  def show_menu
    puts ''
    puts "Please choose an option by entering a number:
  1 - List all books
  2 - List all music albums
  3 - List of games
  4 - List all genres (e.g 'Comedy', 'Thriller')
  5 - List all labels (e.g. 'Gift', 'New')
  6 - List all authors (e.g. 'Stephen King')
  7 - Add a book
  8 - Add a music album
  9 - Add a game
  10 - Exit"
    user_selection
  end

  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/MethodLength
  def user_selection
    selection = gets.chomp.to_i
    case selection
    when 1
      app.list_all_books
      show_menu
    when 2
      app.list_all_music_albums
      show_menu
    when 3
      app.list_of_games
      show_menu
    when 4
      app.list_all_genres
      show_menu
    when 5
      app.list_all_labels
      show_menu
    when 6
      app.list_all_authors
      show_menu
    when 7
      app.add_book
      show_menu
    when 8
      app.add_music_album
      show_menu
    when 9
      app.add_game
      show_menu
    when 10
      abort('Thank you for using this app!')
    else
      puts 'Invalid selection'
      show_menu
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/MethodLength
end

Main.new
