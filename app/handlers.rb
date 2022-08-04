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
      filter_labels = @labels.filter { |label| label.title == music.label }
      new_music = MusicAlbum.new(music.publish_date)
      new_music.label = filter_labels[0]
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

  def if_has_genre(arr, input, album)
    selected = arr.select { |genre| genre.name == input }
    if selected.length.positive?
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

  def if_has_author(arr, input, album)
    selected = arr.select { |author| author.first_name == input }
    if selected.length.positive?
      album.add_author(selected[0])
    else
      author = Author.new(input, '')
      album.add_author(author)
      @authors << author unless @authors.include? author
    end
  end

  def if_label_empty(input, album)
    label = Label.new(input)
    album.label = label
    @labels << label
  end

  def if_has_label(arr, input, album)
    selected = arr.select { |label| label.title == input }
    if selected.length.positive?
      album.label = selected[0]
    else
      label = Label.new(input)
      album.label = label
      @labels << label unless @labels.include? label
    end
  end
end
