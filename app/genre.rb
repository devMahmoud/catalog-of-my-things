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
      'name' => @name
    }.to_json(*args)
  end

  def self.json_create(genre)
    new(genre['name'])
  end
end
