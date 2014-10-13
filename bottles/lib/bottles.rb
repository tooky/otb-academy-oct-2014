class Bottles
  def sing
    verses(99,0)
  end

  def verses(start, finish)
    start.downto(finish).map { |remaining|
      verse(remaining) << "\n"
    }.join
  end

  def verse(remaining)
    bcounter = BottleCounter.new(remaining)
    next_bottle_num = bcounter.next_bottle
    next_b_counter = BottleCounter.new(next_bottle_num)

    "#{bcounter.bottles_left.capitalize} #{bcounter.pluralize} of beer on the wall, #{bcounter.bottles_left} #{bcounter.pluralize} of beer.\n" <<
      "#{bcounter.action}, #{next_b_counter.bottles_left} #{next_b_counter.pluralize} of beer on the wall.\n"
  end
end

class BottleCounter
  def initialize(remaining)
    @remaining = remaining
  end

  def pronoun
    if @remaining == 1
      "it"
    else
      "one"
    end
  end

  def pluralize
    if @remaining == 1
      "bottle"
    else
      "bottles"
    end
  end

  def bottles_left
    if @remaining == 0
      "no more"
    else
      @remaining.to_s
    end
  end

  def next_bottle
    if @remaining == 0
      99
    else
      @remaining - 1
    end
  end

  def action
    if @remaining == 0
      "Go to the store and buy some more"
    else
      "Take #{pronoun} down and pass it around"
    end
  end
end