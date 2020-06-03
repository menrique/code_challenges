# Problem
# Write a function name: crossword that takes two string inputs and return a single string result.
# Each input is expected to be a single word:
# - Consisting of only letters a-z
# The method attempts to:
# - Locate the earliest possible intersection of characters between the two words &
# - Crosses both words on the above intersection
# - The first word is to be rendered horizontally; while the second, vertically
# - The results are returned as a single string

# Main function
def crossword(word1, word2)

  # Get the earliest intersections on both combinations (swapping the base and target words)
  x1, y1 = earliest_intersection(word1, word2)
  y2, x2 = earliest_intersection(word2, word1) # Use the proper coordinates orientation

  # Select the nearest intersection to the center (0, 0) by applying the Euclidean distance: √{(x2-x1)2 + (y2-y1)2}
  # Source: https://en.wikipedia.org/wiki/Euclidean_distance#One_dimension
  d1 = Math.sqrt(x1**2 + y1**2)
  d2 = Math.sqrt(x2**2 + y2**2)
  xn, yn = d1 < d2 ? [x1, y1] : [x2, y2]

  # Render the crossword matrix as a string using the nearest intersection
  render_crossword(word1, word2, xn, yn)
end

# Earliest intersection finder
def earliest_intersection(base, target)
  base.each_char.find.with_index.with_object([]) do |(char, base_index), coords|
    target_index = target.index(char)

    # Exit on first match with the coordinates as result
    unless target_index.nil?
      coords.push(base_index).push(target_index) && true
    end
  end
end

# Render the crossword matrix as a string using the given intersection coordinates
def render_crossword(word1, word2, xn, yn)
  x_limit = word1.length - 1
  y_limit = word2.length - 1

  # Using horizontal sweeping
  (0..y_limit).each.with_object('') do |y, result|
    (0..x_limit).each do |x|
      result.concat(
          if y == yn
            word1[x]
          elsif x == xn
            word2[y]
          else
            ' '
          end
      )
      result.concat("\n") if x == x_limit
    end
  end
end

# Testing examples
examples = [
    {word1: 'cat', word2: 'hat'},
    {word1: 'balloon', word2: 'bat'},
    {word1: 'faint', word2: 'test'},
    {word1: 'road', word2: 'dad'},
    {word1: 'dad', word2: 'road'},
]

# Print each crossword example
def print_examples(examples)
  examples.each do |example|
    word1, word2 = example.values

    # Label the words
    puts
    puts label = "#{word1} & #{word2}"
    label.length.times{ print '-' } && puts

    # Render the crossword
    puts crossword(word1, word2)
  end
end

# Go!
print_examples(examples)

# Results
#
# cat & hat
# ---------
#  h
# cat
#  t
#
# balloon & bat
# -------------
# balloon
# a
# t
#
# faint & test
# ------------
# faint
#     e
#     s
#     t
#
# road & dad
# ----------
#  d
# road
#  d
#
# dad & road
# ----------
#  r
#  o
# dad
#  d

# Performance comparison
def crossword_plus(word1, word2, force: false)

  # Get the earliest intersections using both combinations (swapping the base and target words)
  x1, y1 = coords1 = earliest_intersection(word1, word2)
  y2, x2 = coords2 = earliest_intersection(word2, word1) # Use the proper coordinates orientation

  # Select the nearest intersection to the center (0, 0)
  xn, yn = if coords1 == coords2 && !force
             coords1
           else
             # Applying the Euclidean distance: √{(x2-x1)2 + (y2-y1)2}
             # Source: https://en.wikipedia.org/wiki/Euclidean_distance#One_dimension
             d1 = Math.sqrt(x1**2 + y1**2)
             d2 = Math.sqrt(x2**2 + y2**2)
             d1 < d2 ? [x1, y1] : [x2, y2]
           end

  # Render the crossword matrix as a string using the nearest intersection
  render_crossword(word1, word2, xn, yn)
end

puts
require 'benchmark'
Benchmark.bmbm(20) do |bm|
  bm.report("Bypassing Euclidean:") do
    examples.each do |example|
      word1, word2 = example.values
      crossword_plus(word1, word2)
    end
  end

  bm.report("Forcing Euclidean:") do
    examples.each do |example|
      word1, word2 = example.values
      crossword_plus(word1, word2, force: true)
    end
  end
end;nil

# Rehearsal --------------------------------------------------------
# Bypassing Euclidean:   0.000064   0.000004   0.000068 (  0.000065)
# Forcing Euclidean:     0.000038   0.000001   0.000039 (  0.000039)
# ----------------------------------------------- total: 0.000107sec
#
# user     system      total        real
# Bypassing Euclidean:   0.000042   0.000001   0.000043 (  0.000041)
# Forcing Euclidean:     0.000041   0.000001   0.000042 (  0.000040)