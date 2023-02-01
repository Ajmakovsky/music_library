require_relative 'lib/database_connection'
require_relative 'lib/artist_repository'
require_relative 'lib/album_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('music_library')

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


artist_repository = ArtistRepository.new
album_repository = AlbumRepository.new


# artist_repository.all.each do |artist| 
#   puts "#{artist.id} - #{artist.name} - #{artist.genre}"
# end

# album_repository.all.each do |album|
#   p album
# end 

artist = artist_repository.find(4)

puts "Found artist:\n#{artist.id} - #{artist.name} - #{artist.genre}\n
"


album = album_repository.find(3)

puts "Found album:\n#{album.id} - #{album.title} - #{album.release_year} - #{album.artist_id}\n
"
