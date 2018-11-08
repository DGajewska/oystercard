require 'oystercard'

describe Oystercard do
  let(:card) { Oystercard.new }
  let(:paddington) { double :entry_station }
  let(:victoria) { double :exit_station }

  describe "balance test" do

    it 'can check balance' do
      expect(card.balance).to eq 0
    end

    it 'can #top_up card balance' do
      expect{ card.top_up(10) }.to change{ card.balance }.by 10
    end

    it 'prevents balance from going over £90' do
      limit = Oystercard::CARD_LIMIT
      card.top_up(limit)
      top_up_error = "Current balance is #{card.balance}. Oystercard limit is £#{limit}"
      expect{ card.top_up(10) }.to raise_error top_up_error
    end

  end

  describe "fare tests" do

    it 'prevents #touch_in if balance is less than MINIMUM_FARE' do
      minimum_fare_error = "Current balance (£#{card.balance}) is below minimum fare (£#{Oystercard::MINIMUM_FARE})"
      expect{ card.touch_in(paddington) }.to raise_error minimum_fare_error
    end

    it 'reduces the balance by the MINIMUM_FARE when #touch_out' do
      expect{ card.touch_out(victoria) }.to change{ card.balance }.by -Oystercard::MINIMUM_FARE
    end

  end

  describe "touch in/out test" do

    before do
      card.top_up(10)
    end

    it 'expects intially not to be in a journey' do
      expect(card).not_to be_in_journey
    end

    context 'after #touch_in' do

      before do
        card.touch_in(paddington)
      end

      it 'is in journey after #touch_in' do
        expect(card).to be_in_journey
      end

      it 'is not in journey after #touch_out' do
        card.touch_out(victoria)
        expect(card).not_to be_in_journey
      end

      it 'remembers entry station' do
        expect(card.entry_station).to eq paddington
      end
    end

    describe '@journeys' do
      it 'has an empty list of @journeys by default' do
        expect(card.journeys).to be_empty
      end

      it 'expects that #touch_in and #touch_out creates 1 journey' do
        card.touch_in(paddington)
        expect{ card.touch_out(victoria) }.to change{ card.journeys.length }.by 1
      end

    end
  end
end
