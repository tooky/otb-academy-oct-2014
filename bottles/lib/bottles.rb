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
    next_bottle_num = next_bottle(remaining)

    "#{bottles_left(remaining).capitalize} #{pluralize(remaining)} of beer on the wall, #{bottles_left(remaining)} #{pluralize(remaining)} of beer.\n" <<
      "#{action(remaining)}, #{bottles_left(next_bottle_num)} #{pluralize(next_bottle_num)} of beer on the wall.\n"
  end

  def pluralize(remaining)
    if remaining == 1
      "bottle"
    else
      "bottles"
    end
  end

  def pronoun(remaining)
    if remaining == 1
      "it"
    else
      "one"
    end
  end

  def bottles_left(remaining)
    if remaining == 0
      "no more"
    else
      remaining.to_s
    end
  end

  def next_bottle(remaining)
    if remaining == 0
      99
    else
      remaining - 1
    end
  end

  def action(remaining)
    if remaining == 0
      "Go to the store and buy some more"
    else 
      "Take #{pronoun(remaining)} down and pass it around"
    end
  end  
end
