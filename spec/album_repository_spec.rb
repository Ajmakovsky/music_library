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

    expect(albums.length).to eq  4 
    expect(albums.first.id).to eq "1"
    expect(albums.first.title).to eq "Cuz I Love You"
    expect(albums.first.release_year).to eq "2019"
  end 

  context 'returns a single album' do 
    it 'returns the album Cuz I Love You' do 
      repo = AlbumRepository.new

      album = repo.find(1)
      expect(album.title).to eq 'Cuz I Love You'
      expect(album.release_year).to eq '2019'
    end

    it 'returns the album In the Heat of the Night' do 
      repo = AlbumRepository.new

      album = repo.find(3)
      expect(album.title).to eq 'In the Heat of the Night'
      expect(album.release_year).to eq '1979'
      expect(album.artist_id).to eq '3' 
    end 
  end 
end 