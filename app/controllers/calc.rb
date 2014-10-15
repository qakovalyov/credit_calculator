post '/calc' do
  content_type :json

  param :total_amount,  Integer, min: 1000, required: true
  param :interest_rate, Integer, min: 5, max: 100, required: true
  param :term,          Integer, min: 6, max: 36, required: true
  param :type,   String, default: 'differential', required: true

  credit = Credit.new params
  credit.send(credit.credit_type).to_json

end


