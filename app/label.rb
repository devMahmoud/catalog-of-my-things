require_relative './item'
class Label
  attr_reader :items, :title, :color

  def initialize(title, color = 'white', id = rand(1..1000))
    @id = id
    @title = title
    @color = color
    @items = []
  end

  def add_item(item)
    items << item unless items.include? item
    item.label = self
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'title' => @title,
      'color' => @color,
      'id' => @id
    }.to_json(*args)
  end

  def self.json_create(data)
    new(data['title'], data['color'], data['id'])
  end
end
