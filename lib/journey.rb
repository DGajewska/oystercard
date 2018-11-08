require_relative 'oystercard'

class Journey

  attr_reader :entry_station, :journeys

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(card=Oystercard.new)
    @card = card
    @entry_station
    @journeys = []
  end

  def in_journey?
    !@entry_station.nil?
  end

  def touch_in(station)
    minimum_fare_error = "Current balance is below minimum fare (£#{MINIMUM_FARE})"
    fail minimum_fare_error if @card.balance < MINIMUM_FARE
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @journeys << {entry: @entry_station, exit: station}
    @entry_station = nil
  end

  def deduct(fare)
    @card.balance -= fare
  end


end
