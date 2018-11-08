require 'journey'

describe Journey do
  let(:card) { Oystercard.new }
  let(:journey) { Journey.new(card) }
  let(:paddington) { double :entry_station }
  let(:victoria) { double :exit_station }

  describe "fare tests" do

    it 'prevents #touch_in if balance is less than MINIMUM_FARE' do
      minimum_fare_error = "Current balance is below minimum fare (£#{Journey::MINIMUM_FARE})"
      expect{ journey.touch_in(paddington) }.to raise_error minimum_fare_error
    end

    it 'reduces the balance by the MINIMUM_FARE when #touch_out' do
      expect{ journey.touch_out(victoria) }.to change{ card.balance }.by -Journey::MINIMUM_FARE
    end

  end

  describe "touch in/out test" do

    before do
      card.top_up(10)
    end

    it 'expect penalty fare to be applied when duplicate touch in occurs' do
      journey.touch_in(paddington)
      expect{journey.touch_in(paddington)}.to change{ card.balance }.by -Journey::PENALTY_FARE
    end

    it 'expect penalty fare to be applied when duplicate touch out occurs' do
      journey.touch_out(paddington)
      expect{journey.touch_out(paddington)}.to change{ card.balance }.by -Journey::PENALTY_FARE
    end

    context 'after #touch_in' do

      before do
        journey.touch_in(paddington)
      end

      it 'is in journey after #touch_in' do
        expect(journey).to be_in_journey
      end

      it 'is not in journey after #touch_out' do
        journey.touch_out(victoria)
        expect(journey).not_to be_in_journey
      end

      it 'remembers entry station' do
        expect(journey.entry_station).to eq paddington
      end
    end

    describe '@journeys' do
      it 'has an empty list of @journeys by default' do
        expect(journey.journeys).to be_empty
      end

      it 'expects that #touch_in and #touch_out creates 1 journey' do
        journey.touch_in(paddington)
        expect{ journey.touch_out(victoria) }.to change{ journey.journeys.length }.by 1
      end

    end
  end
end
