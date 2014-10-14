require 'rubygems'
require 'sinatra'
require 'sinatra/param'
require 'json'
# require 'pry-byebug'

configure do
  set :public_folder, 'dist'
end

not_found do
  'Your page cannot be found'
end


Dir["./app/models/*.rb"].each { |file| require file }
Dir["./app/helpers/*.rb"].each { |file| require file }
Dir["./app/controllers/*.rb"].each { |file| require file }

