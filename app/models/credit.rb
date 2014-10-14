class Credit
  attr_reader :total_amount, :interest_rate, :term

  def initialize(option)
    @total_amount = option[:total_amount].to_f
    @interest_rate = option[:interest_rate].to_f
    @term = option[:term].to_f
  end

end