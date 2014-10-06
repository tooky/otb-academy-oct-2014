RSpec.describe "nil in Ruby" do
  it "is an object" do
    expect( nil.is_a?(Object) ).to eq(true), "unlike NULL in some other languages"
  end

  it "doesn't throw null pointer exceptions" do
    # Here we're created a begin - rescue - end block so that we can
    # capture the exception thrown, when we send nil a message that it
    # does not understand.

    begin
      nil.a_method_that_does_not_exist
    rescue Exception => exception
      # What sort of exception is thrown
      expect( exception.class ).to eq(exception.class)

      # What extra information does ruby give us?
      expect( exception.message ).to match(/undefined/) # You can replace __ here with part of the message
    end
  end

  it "has a few methods defined on it" do
    expect( nil.nil? ).to eq(true)
    expect( nil.to_s ).to eq("")
    expect( nil.inspect ).to eq("nil")
  end

  it "does nil equal one" do
    cat = 1
    expect( cat.nil? ).to eq(false)
    expect( cat != nil).to eq(true)
  end

  it "can test using exceptions" do
    cat = 1
    if (cat != nil) != true
      raise "cat was nil"
    end
  end







end
