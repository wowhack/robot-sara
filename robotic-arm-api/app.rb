require 'sinatra'
require_relative 'lib/robotic_arm.rb'

set :port, 1025
set :bind, '0.0.0.0'

KNOWN_ACTIONS = ['WAKE_UP','SLEEP','TEST']

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
  status 200
  "ok"
end

get '/perform_action' do
  action  = params[:action].upcase
  seconds = params[:seconds].to_f

  with_retry do
    if KNOWN_ACTIONS.include?(action)
      puts "PERFORMING KNOWN ACTION #{action}"
      perform_known_action(action)
    else
      action_constant = RoboticArm.const_get(action)
      seconds = seconds
      robotic_arm.perform_action(action_constant, seconds)
    end
    status 200
  end
end

def perform_known_action(action)
  case action
  when "WAKE_UP"
    robotic_arm.perform_action(RoboticArm::SHOULDER_DOWN, 2) 
    robotic_arm.perform_action(RoboticArm::BASE_LEFT, 1.5) 
  when "SLEEP"
    robotic_arm.perform_action(RoboticArm::BASE_RIGHT, 1.5) 
    robotic_arm.perform_action(RoboticArm::SHOULDER_UP, 1.4) 
  when "TEST"
    robotic_arm.perform_action(RoboticArm::LED_ON, 4) 
  else
    robotic_arm.perform_action(RoboticArm::LED_ON, 2) 
  end
end
