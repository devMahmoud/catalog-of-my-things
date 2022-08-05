require_relative './item'
require_relative './label'

class Game < Item
  attr_accessor :last_play_at
  attr_reader :multiplayer

  # rubocop:disable Metrics/ParameterLists
  def initialize(multiplayer, last_play_at, publish_date, label = nil, author = nil, source = nil, genre = nil,
                 id = Random.rand(1..1000))
    super(publish_date, label, author, source, genre, id)
    @multiplayer = multiplayer
    @last_play_at = last_play_at
  end
  # rubocop:enable Metrics/ParameterLists

  def can_be_archived?
    time = Time.new
    super && (time.year - last_play_at) > 2
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'title' => label.title,
      'last_play_at' => @last_play_at,
      'multiplayer' => @multiplayer,
      'publish_date' => @publish_date,
      'author' => @author,
      'source' => @source,
      'genre' => @genre,
      'id' => @id
    }.to_json(*args)
  end

  def self.json_create(data)
    new(
      data['multiplayer'],
      data['last_play_at'],
      data['publish_date'],
      Label.new(data['title']),
      data['author'],
      data['source'],
      data['genre'],
      data['id']
    )
  end
end
