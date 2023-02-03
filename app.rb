require_relative 'lib/database_connection'
require_relative 'lib/artist_repository'
require_relative 'lib/album_repository'

# We need to give the database name to the method `connect`.
#DatabaseConnection.connect('music_library')

# Perform a SQL query on the database and get the result set.
# sql = 'SELECT id, title FROM albums;'
# result = DatabaseConnection.exec_params(sql, [])

# # Print out each record from the result set .
# result.each do |record|
#   p record
# end


#sql = 'SELECT id, title, author_name FROM books'

# fill in params above

#result = DatabaseConnection.exec_params(sql, [])


# artist_repository = ArtistRepository.new
# album_repository = AlbumRepository.new


# Welcome to the music library manager!

# What would you like to do?
#  1 - List all albums
#  2 - List all artists

# Enter your choice: 1
# [ENTER]

# Here is the list of albums:
#  * 1 - Doolittle
#  * 2 - Surfer Rosa
#  * 3 - Waterloo
#  * 4 - Super Trouper
#  * 5 - Bossanova
#  * 6 - Lover
#  * 7 - Folklore
#  * 8 - I Put a Spell on You
#  * 9 - Baltimore
#  * 10 -	Here Comes the Sun
#  * 11 - Fodder on My Wings
#  * 12 -	Ring Ring

class Application 
  def initialize(database_name, io, album_repository, artist_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @album_repository = album_repository
    @artist_repository = artist_repository
  end 

  def run
    @io.puts "Welcome to the music library manager!\n1 - List all albums\n2 - List all artists"
    user_choice = @io.gets.chomp

    if user_choice == '1'
      @io.puts "Here's the list of artists:"
      @artist_repository.all.each do |artist|
        @io.puts("#{artist.id} - #{artist.name}")
      end

    elsif user_choice == '2'
      @io.puts "Here's the list of albums:"
      @album_repository.all.each do |album|
        @io.puts("#{album.id} - #{album.title}")
      end
    end
  end
   


  if __FILE__ == $0
    app = Application.new(
      'music_library',
      Kernel,
      AlbumRepository.new,
      ArtistRepository.new
    )
    app.run
  end
end 


# artist_repository.all.each do |artist| 
#   puts "#{artist.id} - #{artist.name} - #{artist.genre}"
# end

# album_repository.all.each do |album|
#   p album
# end 

# artist = artist_repository.find(4)

# puts "Found artist:\n#{artist.id} - #{artist.name} - #{artist.genre}\n
# "


# album = album_repository.find(3)

# puts "Found album:\n#{album.id} - #{album.title} - #{album.release_year} - #{album.artist_id}\n
# "


# repo = ArtistRepository.new

# artist = Artist.new
# artist.name = 'Kiasmos'
# artist.genre = 'Electronic'

# repo.create(artist) #insert into artists

# repo.delete(id) # delete from artists where id = 

# artist = repo.find(1)


# artist.name = 'Whatever'

# repo.update(artist) # UPDATE artists ... WHERE id = 

# @database = 'music_library'
# @io = io
# @album_repository = album_repository
# @artist_repository = artist_repository

# app = Application.new(@database, @io, @album_repository, @artist_repository)
# app.run