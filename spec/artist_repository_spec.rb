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
end 