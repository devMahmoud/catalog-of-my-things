require_relative './item'
require_relative './label'

class Book < Item
  attr_accessor :publisher, :cover_state

  def initialize(publisher, cover_state, publish_date, label = nil, author = nil, source = nil, genre = nil, id = Random.rand(1..1000))
    super(publish_date, label, author, source, genre, id)
    @publisher = publisher
    @cover_state = cover_state
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'title' => self.label.title,
      'publisher' => @publisher,
      'cover_state' => @cover_state,
      'publish_date' => @publish_date,
      'author' => @author,
      'source' => @source,
      'genre' => @genre,
      'id' => @id
    }.to_json(*args)
  end

  def self.json_create(data)
    new(
      data['publisher'],
      data['cover_state'],
      data['publish_date'],
      Label.new(data['title']),
      data['author'],
      data['source'],
      data['genre'],
      data['id']
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
