module Handlers
  def if_genre_empty(input, album)
    genre = Genre.new(input)
    genre.add_item(album)
    @genres << genre
  end

  def if_has_genre(ar, input, album)
    selected = ar.select {|genre| genre.name == input}
    if selected.length > 0
      selected[0].add_item(album)
    else
      genre = Genre.new(input)
      genre.add_item(album)
      @genres << genre unless @genres.include? genre
    end
  end
end