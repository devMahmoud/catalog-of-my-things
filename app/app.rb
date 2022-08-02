class App
  attr_reader :books, :music, :games

  def initialize
    @books = []
    @music = []
    @games = []
  end

  def list_all_books; end

  def list_all_music_albums; end

  def list_of_games; end

  def list_all_genres; end

  def list_all_labels; end

  def list_all_authors; end

  def add_book; end

  def add_music_album; end

  def add_game; end
end
