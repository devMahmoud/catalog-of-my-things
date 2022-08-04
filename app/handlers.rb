module Handlers
  def genre_store
    JSON.parse(File.read('../data/genres.json'), create_additions: true)
  end

  def authors_store
    JSON.parse(File.read('../data/authors.json'), create_additions: true)
  end

  def genre_music
    music_convert = JSON.parse(File.read('../data/music.json'), create_additions: true)
    music_convert.map do |music|
      filter_genres = @genres.filter { |genre| genre.name == music.genre }
      filter_authors = @authors.filter { |author| author.first_name == music.author }
      new_music = MusicAlbum.new(music.publish_date)
      new_music.add_genre(filter_genres[0])
      new_music.add_author(filter_authors[0])
      new_music.id = music.id
      new_music
    end
  end

  def if_genre_empty(input, album)
    genre = Genre.new(input)
    album.add_genre(genre)
    @genres << genre
  end

  def if_has_genre(ar, input, album)
    selected = ar.select {|genre| genre.name == input}
    if selected.length > 0
      album.add_genre(selected[0])
    else
      genre = Genre.new(input)
      album.add_genre(genre)
      @genres << genre unless @genres.include? genre
    end
  end

  def if_author_empty(input, album)
    author = Author.new(input, '')
    album.add_author(author)
    @authors << author
  end

  def if_has_author(ar, input, album)
    selected = ar.select {|author| author.first_name == input}
    if selected.length > 0
      album.add_author(selected[0])
    else
      author = Author.new(input, '')
      album.add_author(author)
      @authors << author unless @authors.include? author
    end
  end
end