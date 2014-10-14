require 'sensor'
class Alarm
  # Fill in the implementation here
  attr_reader :sensor
  attr_accessor :status

  def initialize(sensor)
    @status = nil
    @sensor = sensor
  end

  def check
    if @sensor.sample_pressure.between?(17.5, 21)
      @status = false
    else 
      @status = true
    end
  end
  
  def on?
    @status
  end

end


