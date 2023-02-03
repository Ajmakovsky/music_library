require 'artist_repository'

describe ArtistRepository do 

  def reset_artists_table
    seed_sql = File.read('spec/seeds_artists.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_artists_table
  end

  it 'returns all out artists' do 
    repo = ArtistRepository.new

    artists = repo.all 

    expect(artists.length).to eq 4
    expect(artists.first.id).to eq '1'
    expect(artists.first.name). to eq "Lizzo"
  end 

  context 'returns single artists' do 
    it 'returns a single artist - Lizzo' do 
      repo = ArtistRepository.new

      artist = repo.find(1)
      expect(artist.name).to eq "Lizzo" 
      expect(artist.genre).to eq "Pop" 
    end


    it 'returns a single artist - Pat Benatar' do
      repo = ArtistRepository.new

      artist = repo.find(3)
      expect(artist.name).to eq 'Pat Benatar' 
      expect(artist.genre).to eq "Rock"
    end 

    it 'returns a single artist - Beyonce' do 
      repo = ArtistRepository.new

      artist = repo.find(2)
      expect(artist.name).to eq "Beyonce" 
      expect(artist.genre).to eq "Pop" 
    end

    it 'returns a single artist - Alicia Keys' do 
      repo = ArtistRepository.new

      artist = repo.find(4)
      expect(artist.name).to eq "Alicia Keys" 
      expect(artist.genre).to eq "R&B" 
    end
  end

  it 'creates a new artist' do 
    repo = ArtistRepository.new

    new_artist = Artist.new
    new_artist.name = 'Beatles'
    new_artist.genre = 'Pop'

    repo.create(new_artist)

    artists =  repo.all 
    last_artist = artists.last 

    expect(last_artist.name).to eq 'Beatles'
    expect(last_artist.genre).to eq 'Pop'
  end 

  context 'deletes an artist' do 
    it 'deletes the artist with id 1' do 
      id_to_delete = 1

      repo = ArtistRepository.new
      
      repo.delete(id_to_delete) 

      all_artists = repo.all
      expect(all_artists.length).to eq 3
      expect(all_artists.first.id).to eq '2'
    end 

    it 'deletes 2 artist with id 2 and id 3' do 

      repo = ArtistRepository.new
      
      repo.delete(2) 
      repo.delete(3)

      all_artists = repo.all
      expect(all_artists.length).to eq 2
      expect(all_artists.first.id).to eq '1'
      expect(all_artists.first.name).to eq 'Lizzo'
    end
  end 

  it 'updates an artist' do 
    repo = ArtistRepository.new

    artist = repo.find(1)

    artist.name = 'Banana'
    artist.genre = 'Techno'

    repo.update(artist)

    updated_artist = repo.find(1)

    expect(updated_artist.name).to eq 'Banana'
    expect(updated_artist.genre).to eq 'Techno'
  end 

end 