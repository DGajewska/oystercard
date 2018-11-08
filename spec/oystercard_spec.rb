require 'oystercard'

describe Oystercard do
  let(:card) { Oystercard.new }

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

end
