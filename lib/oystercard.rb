class Oystercard
  attr_reader :balance
  CARD_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @travelling = false
  end

  def top_up(amount)
    top_up_error = "Current balance is #{@balance}. Oystercard limit is £#{CARD_LIMIT}"
    fail top_up_error if @balance + amount > CARD_LIMIT
    @balance += amount
  end

  def in_journey?
    @travelling
  end

  def touch_in
    minimum_fare_error = "Current balance (£#{@balance}) is below minimum fare (£#{MINIMUM_FARE})"
    fail minimum_fare_error if @balance < MINIMUM_FARE
    @travelling = true
  end

  def touch_out
    @travelling = false
    deduct(MINIMUM_FARE)
  end

  private
  def deduct(fare)
    @balance -= fare
  end

end
