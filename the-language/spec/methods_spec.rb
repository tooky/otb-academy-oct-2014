def a_global_method(a, b)
  a + b
end

RSpec.describe "methods in ruby" do
  it "is possible to call a global method" do
    expect( a_global_method(5, 9) ).to eq(14)
  end

  it "is possible to call a method without parens" do
    expect( a_global_method 4, 8 ).to eq(12)
  end

  it "is sometimes ambiguous to leave out parens" do
    # We have used a string and eval here because the code below causes
    # a syntax error.
    code = "a_global_method(4, a_global_method(3, 2))"

    # Ruby doesn't know if this line means:
    #
    #   a_global_method(4, a_global_method(3, 2))
    #
    # or
    #
    #  a_global_method(4, a_global_method(3), 2)

    expect( eval(code) ).to eq 9
  end

  it "is not possible to call methods with the wrong number of arguments" do
    #expect { a_global_method }.to raise_error( __, /__/ ) # HINT: Fill in the error and part of the message

    expect { a_global_method(1,2,3) }.to raise_error( ArgumentError, /wrong number of arguments/ ) # HINT: Fill in the error and part of the message
  end

  def a_method_with_defaults(a, b = :default_value)
    [a, b]
  end

  it "is possible to use default values" do
    expect( a_method_with_defaults(1) ).to eq( [1, :default_value] )
    expect( a_method_with_defaults(1,2) ).to eq( [1, 2] )
  end

  def method_with_var_args(*args)
    args
  end

  it "is possible to create a methods with a variable number of args" do
    expect( method_with_var_args.class ).to eq( Array )
    expect( method_with_var_args ).to eq( [] )
    expect( method_with_var_args(1) ).to eq( [1] )
    expect( method_with_var_args(1,2) ).to eq( [1,2] )
  end

  def method_with_explicit_return
    :a_value
    return :the_value
    :another_value
  end

  it "is possible to return an explicit value" do
    expect( method_with_explicit_return ).to eq( :the_value )
  end

  def method_without_explicit_return
    :a_value
    :the_value
  end

  it "returns the last evaluated statement" do
    expect( method_without_explicit_return ).to eq( :the_value )
  end

  class MyClass
    def the_method
      :the_value
    end

    def calls_the_method
      the_method
    end

    def calls_the_method_on_self
      self.the_method
    end

    def calls_the_private_method
      the_private_method
    end

    def calls_the_private_method_on_self
      self.the_private_method
    end

    private
    def the_private_method
      :the_private_value
    end
  end

  context "methods on objects" do

    let(:an_object) { MyClass.new }

    it "is possible to call methods on objects" do
      expect( an_object.the_method ).to eq( :the_value )
    end

    it "a method on an object can call other methods on that object" do
      expect( an_object.calls_the_method ).to eq( :the_value )
    end

    it "can call a method on self too" do
      expect( an_object.calls_the_method_on_self ).to eq( :the_value )
    end

    it "raises an error when calling a private method" do
      # Fill in the error and part of the message to move on
      expect { an_object.the_private_method }.to raise_error( NoMethodError, /private method/ )
    end

    it "can all a private method on the same object" do
      expect( an_object.calls_the_private_method ).to eq( :the_private_value )
    end

    it "raises an error if a private method has an explicit receiver" do
      expect{ an_object.calls_the_private_method_on_self }.to raise_error( NoMethodError, /private method/ )
    end

  end

  class Base

    def public_method; :public_method; end

    protected

    def protected_method; :protected_method; end

    private

    def private_method; :private_method; end
  end

  class Specific < Base
    def public_method_calling_private
      private_method
    end

    def public_method_calling_private_explicitly
      self.private_method
    end

    def public_method_calling_protected
      protected_method
    end

    def public_method_calling_protected_explictly
      self.protected_method
    end

    def calls_the_protected_method_on_other(klass)
      klass.protected_method
    end
  end

  class Standalone
    def calls_protected(klass)
      klass.protected_method 
    end

    def calls_private(klass)
      klass.private_method
    end

    protected

    def protected_method; :protected_method; end
  end

  describe Specific do
    let(:object) { Specific.new }

    it "can call public methods of parent" do
      expect(object.public_method).to eq(:public_method)
    end

    it "cannot access parent's private method" do
      expect{object.private_method}.to raise_error(NoMethodError)
    end

    it "can access private/protected methods from parents with implicit receiver" do
      expect(object.public_method_calling_private).to eq(:private_method)
      expect(object.public_method_calling_protected).to eq(:protected_method)
    end

    it "cannot access private methods from parent with explicit receiver" do
      expect{ object.public_method_calling_private_explicitly }.to raise_error(NoMethodError)
    end

    it "can call a protected method on another instance of itself" do
      another = Specific.new
      expect { object.calls_the_protected_method_on_other(another) }.not_to raise_error
    end

    it "cannot call a protected method on an instance of another class" do
      another = Standalone.new
      expect{ object.calls_the_protected_method_on_other(another) }.to raise_error(NoMethodError)
    end
  end

  describe Standalone do
    let(:object) { Standalone.new }

    it "cannot access private/protected methods with explicit receiver" do
      expect{ object.calls_private(Base.new) }.to raise_error(NoMethodError)
      expect{ object.calls_protected(Base.new) }.to raise_error(NoMethodError)
    end
  end

end
