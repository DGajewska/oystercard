require 'oystercard'

describe Oystercard do
  card = Oystercard.new
  card.top_up(10)

  describe "balance test" do

    it 'can check balance' do
      expect(subject.balance).to eq 0
    end

    it 'can #top_up card balance' do
      expect{ subject.top_up(10) }.to change{ subject.balance }.by 10
    end

    it 'prevents balance from going over £90' do
      limit = Oystercard::CARD_LIMIT
      subject.top_up(limit)
      top_up_error = "Current balance is #{subject.balance}. Oystercard limit is £#{limit}"
      expect{ subject.top_up(10) }.to raise_error top_up_error
    end

  end

  describe "fare tests" do

    it 'prevents #touch_in if balance is less than MINIMUM_FARE' do
      minimum_fare_error = "Current balance (£#{subject.balance}) is below minimum fare (£#{Oystercard::MINIMUM_FARE})"
      expect{ subject.touch_in }.to raise_error minimum_fare_error
    end

    it 'reduces the balance by the MINIMUM_FARE when #touch_out' do
      expect{ card.touch_out }.to change{ card.balance }.by -Oystercard::MINIMUM_FARE
    end

  end

  describe "touch in/out test" do

    it 'expects intially not to be in a journey' do
      expect(subject).not_to be_in_journey
    end

    it 'expects to be in journey after #touch_in' do
      card.touch_in
      expect(card).to be_in_journey
    end

    it 'expects not to be in journey after #touch_out' do
      card.touch_in
      card.touch_out
      expect(card).not_to be_in_journey
    end

  end
end
