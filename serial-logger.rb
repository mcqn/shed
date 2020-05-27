#!/usr/bin/env ruby
#
# serial-logger.rb <serial port> <baud rate>
#
# Reads data from the serial port given in the first parameter, at the speed given
# in the second parameter, and outputs it to stdout
#
# Example usage:
#   serial-logger.rb /dev/ttyACM0 115200 | ts "%F %.T" | tee output.log
# This will output data received from an Arduino on /dev/ttyACM0, prefix each line
# with a timestamp and then print it to the ternimal and the file output.log
# NB: you may need to install the moreutils package to get the ts command

require 'serialport'

port, speed = ARGV

if port and speed 
  SerialPort.open(port, { baud: speed.to_i }) do |serial|
    while !serial.eof?
      line = serial.gets.strip
      STDOUT.puts(line)
      STDOUT.flush
    end
  end
else
  puts "usage: serial-logger.rb PORT_TO_MONITOR BAUD_RATE"
end
