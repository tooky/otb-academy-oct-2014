C = "top level"

class More
  C = "nested"

  def self.local
    C
  end

  def self.double_colon
    ::C
  end
end

describe "Ruby Constant" do

  it "references local constants" do
<<<<<<< HEAD
    expect( More.local ).to eq( "nested" )
  end

  it "uses double colon to reference global constants" do
    expect( More.double_colon ).to eq( "top level" )
  end

  it "references nested constants using their complete path" do
    expect( More::C ).to eq( "nested" )
    expect( ::More::C ).to eq( "nested" )
=======
    expect( More.local ).to eq("nested")
  end

  it "uses double colon to reference global constants" do
    expect( More.double_colon ).to eq("top level")
  end

  it "references nested constants using their complete path" do
    expect( More::C ).to eq("nested")
    expect( ::More::C ).to eq("nested")
>>>>>>> 3dcaae5b48bb6b1b9a4fd2fa372ac9dd25e6cbcd
  end

  class Animal
    LEGS = 4
    def legs_in_animal
      LEGS
    end

    class NestedAnimal
      def legs_in_nested_animal
        LEGS
      end
    end
  end

  it "inherits constants from enclosing classes" do
<<<<<<< HEAD
    expect( Animal::NestedAnimal.new.legs_in_nested_animal ).to eq( 4 )
=======
    expect( Animal::NestedAnimal.new.legs_in_nested_animal ).to eq(4)
>>>>>>> 3dcaae5b48bb6b1b9a4fd2fa372ac9dd25e6cbcd
  end

  class Reptile < Animal
    def legs_in_reptile
      LEGS
    end
  end

  it "inherits constants in subclasses from the parent class" do
<<<<<<< HEAD
    expect( Reptile.new.legs_in_reptile ).to eq( 4 )
=======
    expect( Reptile.new.legs_in_reptile ).to eq(4)
>>>>>>> 3dcaae5b48bb6b1b9a4fd2fa372ac9dd25e6cbcd
  end

  class MyAnimals
    LEGS = 2

    class Bird < Animal
      def legs_in_bird
        LEGS
      end
    end
  end

  it "..." do
    expect(Reptile::LEGS != MyAnimals::LEGS).to eq true
  end

  it "can add a new constant in a subclass" do
<<<<<<< HEAD
    expect( MyAnimals::Bird.new.legs_in_bird ).to eq( 2 )
=======
    expect( MyAnimals::Bird.new.legs_in_bird ).to eq(2)
>>>>>>> 3dcaae5b48bb6b1b9a4fd2fa372ac9dd25e6cbcd
  end

  class MyAnimals::Oyster < Animal
    def legs_in_oyster
      LEGS
    end
  end

  it "is different when the lexical scope changes" do
<<<<<<< HEAD
    expect( MyAnimals::Oyster.new.legs_in_oyster ).to eq( 4 )
=======
    expect( MyAnimals::Oyster.new.legs_in_oyster ).to eq(4)
>>>>>>> 3dcaae5b48bb6b1b9a4fd2fa372ac9dd25e6cbcd
  end
end

