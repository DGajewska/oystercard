require 'station'

describe Station do
  let(:station) { Station.new("Barbican", 1) }

  it 'exposes a @name varibale' do
    expect(station.name).to eq "Barbican"
  end

  it 'exposes a @zone varibale' do
    expect(station.zone).to eq 1
  end

end
