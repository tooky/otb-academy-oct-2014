RSpec.describe "ruby's keyword args" do

  def method_with_keyword_arguments(one: 1, two: 'two')
    [one, two]
  end

  it "is possible to define a method with keyword arguments" do
    expect( method_with_keyword_arguments.class ).to eq( Array )
    expect( method_with_keyword_arguments ).to eq( [1, 'two'] )
    expect( method_with_keyword_arguments(one: 'one') ).to eq( ['one', 'two'] )
    expect( method_with_keyword_arguments(two: 2) ).to eq( [1,2] )
  end

  def method_with_keyword_arguments_with_mandatory_argument(one, two: 2, three: 3)
    [one, two, three]
  end

  it "is possible to define a method with regular and keyword arguments" do
    expect { method_with_keyword_arguments_with_mandatory_argument }.to raise_error( ArgumentError, /number of arguments/ )
  end

  def method_with_keyword_without_default(one:, two:)
    [one,two]
  end

  it "is possible to define a method using keyword without default value" do
    expect {method_with_keyword_without_default(two: 1,one: 2)}.not_to raise_error
    expect {method_with_keyword_without_default(one: 1)}.to raise_error( ArgumentError )
  end

end
