require 'sinatra'
require_relative 'lib/recommendations.rb'

set :port, 1026
set :bind, '0.0.0.0'

def recommendations
  @@recommendations ||= Recommendations.new
end

def with_retry(&block)
  tries ||= 3

  begin
    block.call
  rescue Exception => e
    retry unless (tries -= 1).zero?
  end
end

get '/status' do
   status 200
  "ok"
end

get '/recommendations' do
  with_retry do
    data = recommendations.all
    status 200
    data
  end
end
