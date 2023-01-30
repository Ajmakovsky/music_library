require_relative 'artist'

class ArtistRepository

  # Selecting all records
  # No arguments
  def all
    sql = 'SELECT id, name, genre FROM artists'
    result_set = DatabaseConnection.exec_params(sql, [])
    # Executes the SQL query:
    # SELECT id, name, genre FROM artists;

    artists = []

    result_set.each do |record|
      artist = Artist.new
      artist.id = record['id']
      artist.name = record['name']
      artist.genre = record['genre']

      artists << artist
    end 
    # Returns an array of Artist objects.

    return artists
  end
end