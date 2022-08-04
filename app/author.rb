class Author
  attr_accessor :items
  attr_reader :first_name, :last_name

  def initialize(first_name, last_name)
    @id = Random.rand(1..1000)
    @first_name = first_name
    @last_name = last_name
    @items = []
  end

  def add_item(item)
    items << item unless items.include? item
    item.add_author(self)
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'name' => @first_name,
      'items' => @items
    }.to_json(*args)
  end

  def self.json_create(author)
    author_data = new(author['name'], '')
    author['items'].each do |item|
      author_data.add_item(item)
    end
    author_data
  end
end
