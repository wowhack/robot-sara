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

get '/' do
  with_retry do
    robotic_arm.perform_action(RoboticArm::BASE_RIGHT, 1)
  end
end
