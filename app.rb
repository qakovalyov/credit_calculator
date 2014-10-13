require 'rubygems'
require 'sinatra'
require 'sinatra/param'
require 'json'

set :public_folder, 'dist'


get '/' do
  File.read(File.join('app/views/', 'index.html'))
end

post '/calculating' do
  content_type :json
  param :total_amount,  Integer, required: true
  param :term,          Integer, required: true
  param :interest_rate, Integer, required: true

  params.to_json
end