module Store
  def genre_music
    added_gender = []
    music_convert = JSON.parse(File.read('../data/music.json'), create_additions: true)
    music_convert.each do |music|
      filter_genres = @genres.filter { |genre| genre.name == music.genre }
      new_music = MusicAlbum.new(music.publish_date)
      new_music.add_genre(filter_genres[0])
      new_music.add_author(music.author)
      new_music.id = music.id
      added_gender << new_music
    end
    added_gender
  end
end