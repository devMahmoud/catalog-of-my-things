require './item'
class Label
  attr_reader :items

  def initialize(title, color)
    @id = Random.rand(1..1000)
    @title = title
    @color = color
    @items = []
  end

  def add_item(item)
    items << item unless items.include? item
    item.label = self
  end
end