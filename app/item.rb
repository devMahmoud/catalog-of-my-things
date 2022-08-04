class Item
  attr_accessor :label, :id, :author, :genre
  attr_reader :source, :publish_date, :archived

  def initialize(date, archived: false)
    @id = Random.rand(1..1000)
    @publish_date = date
    @archived = archived
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
