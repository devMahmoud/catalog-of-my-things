class Author
  attr_accessor :items
  attr_reader :firts_name, :last_name

  def initialize(firts_name, last_name)
    @id = Random.rand(1..1000)
    @firts_name = firts_name
    @last_name = last_name
    @items = []
  end

  def add_item(item)
    items << item unless items.include? item
    item.add_author(self)
  end
end
