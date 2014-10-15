class Credit
  attr_reader :total_amount, :interest_rate, :term, :credit_type

  def initialize(option)
    @total_amount = option[:total_amount].to_f
    @interest_rate = option[:interest_rate].to_f
    @term = option[:term].to_f
    @credit_type = option[:type]
  end

  protected

  def differential
    result = Array.new
    month_debt = @total_amount/@term
    for i in 0..(@term - 1)
      loan_balance = @total_amount - month_debt*i
      accrued_interest = loan_balance * @interest_rate  * 1/1200
      month_payment  = month_debt + accrued_interest
      result[i] = [ month_debt.round(2), loan_balance.round(2), accrued_interest.round(2), month_payment.round(2) ]
    end
    result
  end

  def annuity
    result = Array.new
    month_percent_rate = @interest_rate / 1200
    month_payment = @total_amount*(month_percent_rate + (month_percent_rate/((1 + month_percent_rate)**@term - 1)))
    loan_balance_first = @total_amount
    accrued_interest_first = loan_balance_first * month_percent_rate
    month_debt = month_payment - accrued_interest_first
    result[0] = [ month_debt.round(2), loan_balance_first.round(2), accrued_interest_first.round(2), month_payment.round(2) ]
    for i in 1..(@term - 1)
      loan_balance = result[i-1][1] - result[i-1][0]
      accrued_interest = loan_balance * month_percent_rate
      month_debt = month_payment - accrued_interest
      result[i] = [ month_debt.round(2), loan_balance.round(2), accrued_interest.round(2), month_payment.round(2) ]
    end
    result
  end


end