require_relative './item'

class Book < Item
  attr_accessor :publisher, :cover_state

  def initialize(publisher, cover_state, publish_date, label = nil, author = nil, source = nil, genre = nil)
    super(publish_date, label, author, source, genre)
    @publisher = publisher
    @cover_state = cover_state
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'title' => @label,
      'publisher' => @publisher,
      'cover_state' => @cover_state,
      'publish_date' => @publish_date,
      'author' => @author,
      'source' => @source,
      'genre' => @genre
    }.to_json(*args)
  end

  def self.json_create(data)
    new(
      data['publisher'],
      data['cover_state'],
      data['publish_date'],
      data['title'],
      data['author'],
      data['source'],
      data['genre']
    )
  end

  private

  def can_be_archived?
    if super || cover_state == 'bad'
      true
    else
      false
    end
  end
end
