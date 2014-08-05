require 'sinatra'
require './lib/robotic_arm.rb'

set :port, 1025

get '/' do
  "PONG"
end
