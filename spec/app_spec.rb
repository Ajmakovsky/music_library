require_relative '../app.rb'

describe Application do
  
  before(:each) do 
    @database = 'music_library_test'
    @io = double :io
    @album_repository = double :album_repository
    @artist_repository = double :artist_repository


    album_1 = double(:album, :id => '1', :title => "Cuz I Love You")
    album_2 = double(:album, :id => '2', :title => "Lemonade")

    allow(@album_repository).to receive(:all).and_return([album_1, album_2])

    artist_1 = double(:artist, :id => '1', :name => 'Lizzo')
    artist_2 = double(:artist, :id => '2', :name => 'Beyonce')


    allow(@artist_repository).to receive(:all).and_return([artist_1, artist_2])

  end

  after(:each) do 
    app = Application.new(@database, @io, @album_repository, @artist_repository)
    app.run
  end

   it 'prints a list of options in the terminal, gets user input, and displays option 1' do 
    expect(@io).to receive(:puts).with("Welcome to the music library manager!\n1 - List all albums\n2 - List all artists").ordered
    expect(@io).to receive(:gets).and_return('1')
    expect(@io).to receive(:puts).with("Here's the list of artists:")
    expect(@io).to receive(:puts).with("1 - Lizzo")
    expect(@io).to receive(:puts).with("2 - Beyonce")
  end 

  it 'prints a list of options in the terminal, gets user input, and displays option 1' do 
    expect(@io).to receive(:puts).with("Welcome to the music library manager!\n1 - List all albums\n2 - List all artists").ordered
    expect(@io).to receive(:gets).and_return('2')
    expect(@io).to receive(:puts).with("Here's the list of albums:")
    expect(@io).to receive(:puts).with("1 - Cuz I Love You")
    expect(@io).to receive(:puts).with("2 - Lemonade")
  end

end 