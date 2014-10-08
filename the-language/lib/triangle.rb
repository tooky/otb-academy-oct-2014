# Triangle Project Code.

# Triangle analyzes the lengths of the sides of a triangle
# (represented by a, b and c) and returns the type of triangle.
#
# It returns:
#   :equilateral  if all sides are equal
#   :isosceles    if exactly 2 sides are equal
#   :scalene      if no sides are equal
#
# The tests for this method can be found in
#   about_triangle_project.rb
# and
#   about_triangle_project_2.rb
#
def triangle(a, b, c)
  Triangle.new(a, b, c).type
end

class Triangle
  attr_reader :type

  def initialize(a, b, c)
    @a, @b, @c = a, b, c
    validate!
    calculate_triangle
  end

  private

  def validate!
    if !valid?
      raise TriangleError, 'invalid arguments'
    end
  end

  def valid?
    if @a + @b > @c && @a + @c > @b && @b + @c > @a
      true
    else
      false
    end
  end

  def calculate_triangle
    if is_equilateral?
      @type = :equilateral
    elsif is_isosceles?
      @type = :isosceles
    elsif is_scalene?
      @type = :scalene
    end
  end

  def is_equilateral?
    @a == @b && @b == @c
  end

  def is_isosceles?
    @a == @b || @a == @c || @b == @c
  end

  def is_scalene?
    @a != @b && @b != @c
  end
end

# Error class used in part 2.  No need to change this code.
class TriangleError < StandardError
end

