# 1. In whatever OOP language you prefer, write classes that model the animals available for adoption at the SPCA: dogs,
# cats, and guinea pigs. All of them have a name, description, and date they arrived at the shelter. Dog objects should
# have a list of their favorite dog friends, connecting one Dog to another (don’t worry about the database layer, just
# model it in the class). Cat objects should have a way to save and display the cat’s favorite food, and store whether
# or not the cat likes Dogs. Guinea pigs come in a litter, so their objects need a way to associate it with siblings.

class Animal
  attr_accessor :name, :description, :arrival_date

  def initialize(name, description, arrival_date)
    self.name = name
    self.description = description
    self.arrival_date = arrival_date
  end
end

class Dog < Animal
  attr_accessor :friends

  def initialize(name, description, arrival_date, friends: [])
    super(name, description, arrival_date)
    self.friends = friends
  end

  def friend_of?(dog)
    friends.include?(dog)
  end
end

class Cat < Animal
  attr_accessor :like_dogs, :favorite_food

  def initialize(name, description, arrival_date, like_dogs: false, favorite_food: nil)
    super(name, description, arrival_date)
    self.like_dogs = like_dogs
    self.favorite_food = favorite_food
  end

  def like_dogs?
    like_dogs
  end

  def favorite?(food)
    food == favorite_food
  end
end

class GuineaPig < Animal
  attr_accessor :litter

  def initialize(name, description, arrival_date, litter: nil)
    super(name, description, arrival_date)
    self.litter = litter
  end

  def sibling_with?(guinea_pig)
    litter == guinea_pig.litter
  end
end

# Sample
require 'date'

# Using dogs
buddy, molly, teddy = [
    { name: 'Buddy', description: 'The most loyal friend', arrival_date: Date.parse('10-02-2020') },
    { name: 'Molly', description: 'A beautiful puffy princess', arrival_date: Date.parse('15-03-2020') },
    { name: 'Teddy', description: 'Cozy little barker', arrival_date: Date.parse('21-03-2020') },
].inject([]) do |dogs, attrs|
  dogs << Dog.new(attrs[:name], attrs[:description], attrs[:arrival_date], friends: dogs.dup)
end

molly.name
# => Molly

molly.friends.map(&:name)
# => ["Buddy"]

molly.friend_of?(buddy)
# => true

molly.friend_of?(teddy)
# => false

# Using cats
tiger, sassy, misty = [
    { name: 'Tiger', description: 'The hunter of the house', arrival_date: Date.parse('07-01-2020'), like_dogs: false, favorite_food: 'chicken' },
    { name: 'Sassy', description: 'Lively and bold companion', arrival_date: Date.parse('28-12-2019'), like_dogs: true, favorite_food: 'fish' },
    { name: 'Misty', description: 'She hides during the day', arrival_date: Date.parse('13-01-2020'), like_dogs: false },
].inject([]) do |cats, attrs|
  cats << Cat.new(attrs[:name], attrs[:description], attrs[:arrival_date], like_dogs: attrs[:like_dogs], favorite_food: attrs[:favorite_food])
end

tiger.description
# => 'The hunter of the house'

tiger.favorite_food
# => 'chicken'

sassy.like_dogs?
# => true

misty.favorite_food = 'milk'
# => 'milk'

misty.favorite?('milk')
# => true

# Using guinea pigs
jelly_bean, pancake, dottie = [
    { name: 'Jelly Bean', description: 'Sweet and colorful', arrival_date: Date.parse('28-12-2019'), litter: '001' },
    { name: 'Pancake', description: 'Jummy little friend', arrival_date: Date.parse('28-12-2019'), litter: '001' },
    { name: 'Dottie', description: 'Black and white', arrival_date: Date.parse('15-02-2020'), litter: '002' },
].inject([]) do |cats, attrs|
  cats << GuineaPig.new(attrs[:name], attrs[:description], attrs[:arrival_date], litter: attrs[:litter])
end

jelly_bean.arrival_date.strftime('%a, %d %b %Y')
# => "Sat, 28 Dec 2019"

jelly_bean.sibling_with?(pancake)
# => true

jelly_bean.sibling_with?(dottie)
# => false