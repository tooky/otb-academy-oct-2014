require 'alarm'
RSpec.describe "tyre pressure alarm" do
  

  let(:sensor){ double("Sensor", :sample_pressure => sample_pressure)}
  let(:sample_pressure){ 17.8}
  let(:alarm) {Alarm.new(sensor)}

  it "should init with sensor results" do
    expect(alarm.sensor.sample_pressure).to eq(17.8)
  end

  it 'should check sensor results' do
    alarm.check
    expect([true, false]).to include(alarm.status)
  end
  context "status of alarm is on!" do
 
    it 'should be off' do
      alarm.check
      expect(alarm.on?).to be false
    end
  end

  context "status to be on " do
    let(:sample_pressure){ 5.6 }
    it 'should be on' do
      alarm.check
      expect(alarm.on?).to be true
    end
  end

  context "alarm situation" do

    let(:sample_pressure){ 10 }
    
    it 'should be on and off' do 
      alarm.check
      expect(alarm.on?).to be true
      # sensor pressure is now normal????
      allow(sensor).to receive(:sample_pressure).and_return(20)
      alarm.check
      expect(alarm.on?).to be false
    end
  end
  context "creating fake sensor" do
   class FakeSensor
     attr_accessor :sample_pressure
    end 
    let(:sensor){FakeSensor.new }
    it 'should be on and off' do 
      sensor.sample_pressure = 10
      alarm.check
      expect(alarm.on?).to be true
      # sensor pressure is now normal????
      sensor.sample_pressure = 19
      alarm.check
      expect(alarm.on?).to be false
    end
  end
end
