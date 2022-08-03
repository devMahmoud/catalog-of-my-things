require_relative './item'

class MusicAlbum < Item
  attr_accessor :on_spotify, :id
  attr_reader :genre

  def initialize(date, spotify: false, archived: false)
    super(date, archived: archived)
    @on_spotify = spotify
  end

  def can_be_archived?
    time = Time.new
    if time.year - publish_date > 10 && on_spotify
      true
    else
      false
    end
  end
  
  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'id' => id,
      'date' => publish_date,
      'author' => author,
      'genre' => genre.name
    }.to_json(*args)
  end

  def self.json_create(data)
    music_album = new(data['date'])
    music_album.id = data['id']
    music_album.add_author(data['author'])
    music_album.add_genre(data['genre'])
    music_album
  end
  private :can_be_archived?
end
