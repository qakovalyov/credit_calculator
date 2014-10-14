post '/calc' do
  content_type :json

  param :total_amount,  Integer, min: 1000, required: true
  param :term,          Integer, min: 6, max: 36, required: true
  param :interest_rate, Integer, min: 5, max: 100, required: true

  credit = Credit.new params
  calc(credit).to_json
end

def calc credit
  result = Array.new
  for i in 0..(credit.term - 1)
    month_debt = credit.total_amount/credit.term
    loan_balance = credit.total_amount - month_debt*i
    accrued_interest = loan_balance * credit.interest_rate  * 1/1200
    payment  = month_debt + accrued_interest
    result[i] = [ month_debt.round(2), loan_balance.round(2), accrued_interest.round(2), payment.round(2) ]
  end
  result
end

