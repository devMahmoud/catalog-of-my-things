class Item
  attr_reader :genre, :author, :source, :label

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

  def add_label(label)
    @label = label
  end
end
