require 'sensor'
require 'alarm'
require 'blink_notifier'

$alarm = Alarm.new(Sensor.new, BlinkNotifier.new)