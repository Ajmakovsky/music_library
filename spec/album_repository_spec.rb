require 'album_repository'

describe AlbumRepository do 

  def reset_albums_table
    seed_sql = File.read('spec/seeds_albums.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_albums_table
  end

  it 'tests the all method with psql' do 

    repo = AlbumRepository.new

    albums = repo.all

    expect(albums.length).to eq  2 
    expect(albums.first.id).to eq "1"
    expect(albums.first.title).to eq "Cuz I Love You"
    expect(albums.first.release_year).to eq "2019"
  end 
end 