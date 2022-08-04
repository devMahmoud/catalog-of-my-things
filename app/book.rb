require_relative './item'

class Book < Item
  attr_accessor :publisher, :cover_state

  def initialize(publisher, cover_state, publish_date)
    super(publish_date)
    @publisher = publisher
    @cover_state = cover_state
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      'publisher' => @publisher,
      'cover_state' => @cover_state,
      'publish_date' => @publish_date,
      'label' => @label
    }.to_json(*args)
  end

  def self.json_create(data)
    new(data['publisher'], data['cover_state'], data['publish_date'])
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
