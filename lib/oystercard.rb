require_relative 'journey'

class Oystercard
  attr_accessor :balance
  CARD_LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    top_up_error = "Current balance is #{@balance}. Oystercard limit is £#{CARD_LIMIT}"
    fail top_up_error if @balance + amount > CARD_LIMIT
    @balance += amount
  end

  # def check_balance(minimum)
  #   @balance > minimum
  # end

end
