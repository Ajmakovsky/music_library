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

  def find(id)
    sql = 'SELECT id, name, genre FROM artists WHERE id = $1;'
    sql_params = [id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)

    record = result_set[0]

    artist = Artist.new
    artist.id = record['id']
    artist.name = record['name']
    artist.genre = record['genre']

    return artist
  end 
end