require 'sensor'
class Alarm
  # Fill in the implementation here
  attr_reader :sensor, :notifier

  def initialize(sensor, notifier)
    @status = nil
    @sensor = sensor
    @notifier = notifier
  end

  def check
    if @sensor.sample_pressure.between?(17.5, 21)
      notifier.normal_range
    else 
      notifier.out_of_bounds 
    end
  end
  
end


