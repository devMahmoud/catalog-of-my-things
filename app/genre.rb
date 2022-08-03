class Genre
  attr_accessor :items
  attr_reader :name

  def initialize(name)
    @id = Random.rand(1..1000)
    @name = name
    @items = []
  end

  def add_item(item)
    items << item unless items.include? item
    item.add_genre(self)
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'name' => @name,
      'items' => @items
    }.to_json(*args)
  end

  def self.json_create(genre)
    genre_data = new(genre['name'])
    genre['items'].each do |item|
      genre_data.add_item(item)
    end
    genre_data
  end
end
