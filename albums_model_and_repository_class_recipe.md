{{Albums}} Model and Repository Classes Design Recipe


1. Design and create the Table √


2. Create Test SQL seeds
Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,so we can start with a fresh state.

-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE albums RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO albums (title, release_year, artist_id) VALUES ('Cuz I Love You', '2019', '1');
INSERT INTO albums (title, release_year, artist_id) VALUES ('Lemonade', '2016', '2');
INSERT INTO albums (title, release_year, artist_id) VALUES ('In the Heat of the Night', '1979', '3');
INSERT INTO albums (title, release_year, artist_id) VALUES ('Girl on Fire', '2012', '4');


Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql


3. Define the class names
Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.
```ruby
# EXAMPLE
# Table name: albums

# Model class
# (in lib/albums.rb)
class Album
end

# Repository class
# (in lib/album_repository.rb)
class AlbumRepository
end
```

4. Implement the Model class
Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.
```ruby
# EXAMPLE
# Table name: albums

# Model class
# (in lib/album.rb)

class Album

  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :release_year, :artist_id
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name

```

You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.

5. Define the Repository Class interface
Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.


```ruby 
# EXAMPLE
# Table name: students

# Repository class
# (in lib/student_repository.rb)

class StudentRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, release_year, and artist_id FROM albums;

    # Returns an array of Album objects.
  end

  def find(id)
    # executes the SQL query: 
    # SELECT id, title, release_year and artist_id FROM albums WHEN id = $1; 

    #returns a single album 
  end 

  def create(album)
    # executes the SQL query: 
    # INSERT INTO artists (name, genre) VALUES($1, $2);

    # returns nothing 
  end
end

```


6. Write Test Examples
Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.
```ruby 
# EXAMPLES

# 1
# Get all students

repo = AlbumRepository.new

albums = repo.all

albums.length => 2 
albums.first.id => "1"
albums.first.title => "Cuz I Love You"
albums.first.release_year => "2019"

# 2
# get a single album 

repo = AlbumRepository.new

album = repo.find(1)
album.title # => 'Cuz I Love You'
album.release_year # => '2019' 

# 3
# get a single album

repo = AlbumRepository.new

album = repo.find(3)
album.title # => 'In the Heat of the Night'
album.release_year # => '1979' 
album.artist_id # => '3'

# 4
# Create a new album

repo = AlbumRepository.new

album = Album.new
album.name = 'Man on the Moon: The End of Day'
album.genre = '2009'

repo.create(album) => nil

albums =  repo.all 

last_album = album.last 
last_album.name # => 'Man on the Moon: The End of Day'
last_album.genre # => '2009'

```



7. Reload the SQL seeds before each test run
Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end
8. Test-drive and implement the Repository class behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.