require "json" #$ include an external module $$
require_relative "my_module" #$ include a module I wrote $$

def get_numbers_stack(list) #$ defining a method $$
  #$ In Ruby, you don't have to declare variable types
  stack  = [[0, []]]
  output = [] #$$
  until stack.empty? #$ 'unless' is a unique keyword to Ruby $$
    index, taken = stack.pop
    next output << taken if index == list.size # I do NOT want to see this comment on Mindbase
    stack.unshift [index + 1, taken]
    stack.unshift [index + 1, taken + [list[index]]]
  end
  output
end
