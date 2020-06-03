# 1. In the language of your choice, write a function that takes an array of English sentences of any size
# that prints out each sentence, but, in each, turns all words with an odd number of letters lowercase,
# and those with an even number of letters uppercase.

def odd_down_even_up(sentences)
  word = ->(fragment){ fragment.scan(/\w+/).first || '' }
  transform = ->(fragment){word[fragment].size.odd? ? fragment.downcase : fragment.upcase}

  sentences.each do |sentence|
    puts sentence.split(' ').map{|fragment| transform[fragment]}.join(' ')
  end
end

# Sample
sentences = [
    'The forest is the town of trees',
    'Where they live quite at their ease',
    'With their neighbors at their side',
    'Just as we in cities wide.'
]
odd_down_even_up(sentences)
# =>
# the FOREST IS the TOWN OF trees
# where THEY LIVE quite AT their EASE
# WITH their neighbors AT their SIDE
# JUST AS WE IN CITIES WIDE.