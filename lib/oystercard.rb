class Oystercard
  attr_reader :balance, :entry_station, :journeys
  CARD_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @entry_station
    @journeys = []
  end

  def top_up(amount)
    top_up_error = "Current balance is #{@balance}. Oystercard limit is £#{CARD_LIMIT}"
    fail top_up_error if @balance + amount > CARD_LIMIT
    @balance += amount
  end

  def in_journey?
    !@entry_station.nil?
  end

  def touch_in(station)
    minimum_fare_error = "Current balance (£#{@balance}) is below minimum fare (£#{MINIMUM_FARE})"
    fail minimum_fare_error if @balance < MINIMUM_FARE
    @entry_station = station
  end

  def touch_out(station)
    @entry_station = nil
    deduct(MINIMUM_FARE)
    @journeys << {entry: @entry_station, exit: station}
  end

  private
  def deduct(fare)
    @balance -= fare
  end

end
