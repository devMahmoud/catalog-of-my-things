require './music_album'

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
end
