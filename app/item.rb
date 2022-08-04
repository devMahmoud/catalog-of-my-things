class Item
  attr_accessor :label
  attr_reader :genre, :author, :source, :publish_date, :archived

  def initialize(date, label = nil, author = nil, source = nil, genre = nil, archived: false)
    @id = Random.rand(1..1000)
    @label = label
    @publish_date = date
    @archived = archived
    @author = author
    @source = source
    @genre = genre
  end

  def add_genre(genre)
    @genre = genre
  end

  def add_author(author)
    @author = author
  end

  def add_source(source)
    @source = source
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end

  private

  def can_be_archived?
    time = Time.new
    time.year - publish_date > 10
  end
end
