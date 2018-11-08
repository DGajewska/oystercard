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
    calculate_fare('penalty') if !@entry_station.nil?
    @entry_station = station
  end

  def touch_out(station)
    @entry_station.nil? ? calculate_fare('penalty') : calculate_fare(station)
    @journeys << {entry: @entry_station, exit: station}
    @entry_station = nil
  end

  private
  def calculate_fare(station)
    station == 'penalty' ? deduct(PENALTY_FARE) : deduct(MINIMUM_FARE)
  end

  def deduct(fare)
    @card.balance -= fare
  end


end
