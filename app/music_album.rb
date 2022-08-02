require './item.rb'

class MusicAlbum < Item
  attr_accessor :on_spotify

  def initialize(date, spotify: false, archived: false)
    super(date, archived: archived)
    @on_spotify = spotify
  end

  private

  def can_be_archived?
    time = Time.new
    if time.year - publish_date > 10 && on_spotify
      true
    else
      false
    end
  end
end

