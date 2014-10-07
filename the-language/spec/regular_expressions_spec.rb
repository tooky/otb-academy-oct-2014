RSpec.describe "Regular expressions" do
  # * - dont care what is where never fails cause 0 or more
  # + - one or more
  context "the basics" do
    it "is a pattern" do
      expect( /pattern/.class ).to eq( Regexp )
    end

    it "can search a string for content that matches the pattern" do
      expect( "a string that matches"[/match/] ).to eq( "match" )
    end

    it "returns nil when the match fails" do
      expect( "a string that matches"[/fails/] ).to eq( nil)
    end
  end

  context "characters" do
    it "uses a ? for optional" do
      expect( "abcd"[/ab?/] ).to eq( "ab" )
      expect( "abcd"[/ae?/] ).to eq( "a"  )
    end

    it "uses + to mean one or more" do
      expect( "abcccd"[/bc+/] ).to eq( "bccc" )
    end

    it "uses * to mean zero or more" do
      expect( "abbcccdddd"[/ab*/] ).to eq( "abb" )
      expect( "abbcccdddd"[/az*/] ).to eq( "a" )
      expect( "abbcccdddd"[/z*/] ).to eq( "" )
    end
  end

  it "matches from the left first" do
    expect( "acdz az"[/az*/] ).to eq( 'a' )
  end

  context "character classes" do
    it "can use character classes to provide options" do
      words = ["cat", "sat", "mat"]
      expect( words.select { |w| w[/[cm]at/] } ).to eq( ["cat", "mat"] )
    end

    it "uses \d as a shortcut for a digit character class" do
      expect( "3 is the magic number"[/[0123456789]/] ).to eq( "3" )
      expect( "3 is the magic number"[/\d/] ).to eq( "3" )
    end

    it "allows ranges in character classes" do
      expect( "3 is the magic number"[/[0-9]/] ).to eq( "3" )
    end

    it 'uses \s as the shortcut for white space' do
      expect( "space: \t\n"[/\s+/] ).to eq( " \t\n" )
    end

    it 'uses \w as the shortcut for word characters' do
      expect( "magic_number_1 = 3"[/[a-zA-Z0-9_]+/] ).to eq( "magic_number_1" )
      expect( "magic_number_1 = 3"[/\w+/] ).to eq( "magic_number_1" )
    end

    it 'uses . as a shortcut for any character, except a new line' do
      expect( "abc\n123"[/a.+/] ).to eq( "abc" )
    end

    it 'can negate a character class' do
      expect( "3 is the magic number"[/[^0-9]+/] ).to eq( " is the magic number" )
    end

    it "uses capitals to negate shortcut characters" do
      expect( "3 is the magic number"[/\D+/] ).to eq( " is the magic number" )
      expect( "space: \t\n"[/\S+/] ).to eq( "space:" )
      # ... a programmer would most likely do
      expect( "magic_number_1 = 3"[/[^a-zA-Z0-9_]+/] ).to eq( " = " )
      expect( "magic_number_1 = 42"[/\W+/] ).to eq( " = " )
    end
  end

  context "anchors" do
    it "uses \A to mark the start of the string" do
      expect( "start end"[/\Astart/] ).to eq( "start" )
      expect( "start end"[/\Aend/] ).to eq( nil )
    end

    it "uses \z to mark the end of the string" do
      expect( "start end"[/end\z/] ).to eq( "end" )
      expect( "start end"[/start\z/] ).to eq( nil )
    end

    it "uses ^ to mark the start of lines" do
      expect( "magic number 8\n3 magic number"[/^\d+/] ).to eq( "3" )
    end

    it "uses $ to mark the end of lines" do
      expect( "8 magic number\nmagic number 3"[/\d+$/] ).to eq( "3" )
    end

    it 'uses \b to anchor word boundaries' do
      expect( "wildcat cats"[/\bcat.+/] ).to eq( "cats" )
    end
  end

  it "uses parens to group content" do
    expect( "yohoho"[/(ho)+/] ).to eq( "hoho" )
  end

  context "capturing content" do
    it "also uses parens to capture content" do
      expect( "Gray, James"[/(\w+), (\w+)/, 1] ).to eq( "Gray" )
      #!!!!!! 
      expect( "Gray, James, Gray, Thomas"[/(\w+), (\w+), (\w+)/, 3] ).to eq( "Gray" )
    end
 
    it "has special variables to access captures" do
      expect( "Name: Gray, James"[/(\w+), (\w+)/] ).to eq( "Gray, James" )
      expect( $1 ).to eq( "Gray" )
      expect( $2 ).to eq( "James" )
    end
  end

  it "uses a | to show alternatives" do
    simpsons = /(Bart|Lisa|Maggie) Simpson/

    expect( "Bart Simpson"[simpsons] ).to eq( "Bart Simpson" )
    expect( "Maggie Simpson"[simpsons] ).to eq( "Maggie Simpson" )
    expect( "Montgomery Simpson"[simpsons] ).to eq( nil )
  end

  context "finding and replacing" do
    it "uses scan to find all" do
      expect( "one two-three".scan(/\w+/) ).to eq( ["one", "two","three"] )
    end

    it "uses sub to find and replace" do
      expect( "one two-three".sub(/(t\w*)/) { $1[0, 1] } ).to eq( "one t-three" )
    end

    it "uses gsub to find and replace all" do
      expect( "one two-three".gsub(/(t\w*)/) { $1[0, 1] } ).to eq( "one t-t" )
    end

    it 'checks email address ' do
      expect("asta@gm.lt"[/[a-z0-9]*@[a-z0-9]*[.][a-z0-9]{2,3}/i] ).to eq ("asta@gm.lt")
    end
  end
end
