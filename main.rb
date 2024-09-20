# frozen_string_literal: true

require_relative 'lib/hash_map'

def main # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
  test = HashMap.new

  test.set('apple', 'red')
  test.set('banana', 'yellow')
  test.set('carrot', 'orange')
  test.set('dog', 'brown')
  test.set('elephant', 'gray')
  test.set('frog', 'green')
  test.set('grape', 'purple')
  test.set('hat', 'black')
  test.set('ice cream', 'white')
  test.set('jacket', 'blue')
  test.set('kite', 'pink')
  test.set('lion', 'golden')

  test.set('moon', 'silver')

  p test.entries

  test.set('moon', 'dark')
  p test.remove('ice cream')
  p test.get('kite')
  p test.has?('knife')
  p test.length
  p test.keys
  p test.values
  p test.entries
  p test.clear
  p test.entries
end

main
