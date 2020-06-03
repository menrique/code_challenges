# 1. Given an array or words, write a function that returns an array of sentences no longer than the given chars amount.

words = %w{The African elephant is a very different animal from its Asiatic cousin, both as regards structure and
           habits; and were it not for the existence of intermediate extinct species, might well be regarded as the
           representative of a distinct genus.}

def wrap_lines(words, n = 20)
  result = []
  line = ''

  words.each_with_index do |word, index|
    potential_line = index == 0 ? word : line + ' ' + word

    if potential_line.length <= n
      line = potential_line
    end

    if potential_line.length > n || index == words.length - 1
      result << line
      line = word
    end
  end

  result
end

wrap_lines(words)
# => ["The African elephant", "is a very different", "animal from its", "Asiatic cousin, both", "as regards structure",
#     "and habits; and were", "it not for the", "existence of", "intermediate extinct", "species, might well",
#     "be regarded as the", "representative of a", "distinct genus."]