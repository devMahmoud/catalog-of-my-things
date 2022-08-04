require_relative './item'

class Game < Item
  attr_accessor :last_play_at
  attr_reader :multiplayer

  def initialize(multiplayer, last_play_at, publish_date)
    super(publish_date)
    @multiplayer = multiplayer
    @last_play_at = last_play_at
  end

  def can_be_archived?
    time = Time.new
    super && (time.year - last_play_at) > 2
  end
end
