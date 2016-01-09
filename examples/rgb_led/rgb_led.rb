#
# This is a simple example to blink an led
# every half a second
#
require 'bundler/setup'
require 'dino'

board = Dino::Board.new(Dino::TxRx::Serial.new)
led = Dino::Components::RgbLed.new(pins: {red: 11, green: 10, blue: 9}, board: board)
potentiometer = Dino::Components::Sensor.new(pin: 'A0', board: board)


delay = 500.0

potentiometer.when_data_received do |data|
  sleep 0.5
  puts "DATA: #{delay = data.to_i}"
end

  sleep(2)
loop do
  puts "DELAY: #{seconds = (delay / 1000.0)}"
  p 'red'
  led.red = 255
  sleep(seconds)
  led.blue = 255
  p 'purple'
  sleep(seconds)
  led.green = 255
  p 'white'
  sleep(seconds)
end
