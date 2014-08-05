require 'sinatra'
require_relative 'lib/robotic_arm.rb'

set :port, 1025
set :bind, '0.0.0.0'

def robotic_arm
  @@robotic_arm ||= RoboticArm.new
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
  "ok"
end

get '/perform_action' do
  action  = params[:action]
  seconds = params[:seconds]

  with_retry do
    action_constant = RoboticArm.const_get(action.upcase)
    seconds = seconds.to_f
    robotic_arm.perform_action(action_constant, seconds)
  end
end
