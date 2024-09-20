# frozen_string_literal: true

require_relative 'linked_list'

# Custom hashMap
class HashMap
  INITIAL_CAPACITY = 16
  MAX_LOAD_CAPACITY = 0.75

  def initialize
    @buckets = Array.new(INITIAL_CAPACITY) { LinkedList.new }
    @count = 0
  end

  def set(key, value) # rubocop:disable Metrics/MethodLength
    index = hash_index(key)
    entry = @buckets[index]

    if entry.find(key)
      entry.find(key).value = value
    elsif high_load_capacity
      resize
      set(key, value)
    else
      entry.append(key, value)
      @count += 1
    end
  end

  def length
    @count
  end

  def clear
    @buckets = Array.new(INITIAL_CAPACITY) { LinkedList.new }
    @count = 0
  end

  def keys
    key_array = []
    @buckets.each do |bucket|
      current_node = bucket.head
      while current_node
        key_array << current_node.key unless current_node.key.nil?
        current_node = current_node.next_node
      end
    end
    key_array
  end

  def values
    values_array = []
    @buckets.each do |bucket|
      current_node = bucket.head
      while current_node
        values_array << current_node.value unless current_node.value.nil?
        current_node = current_node.next_node
      end
    end
    values_array
  end

  def entries
    entries_array = []
    @buckets.each do |bucket|
      current_node = bucket.head
      while current_node
        entries_array << [current_node.key, current_node.value]
        current_node = current_node.next_node
      end
    end
    entries_array
  end

  def get(key)
    key_index = hash_index(key)
    node = @buckets[key_index].find(key)
    node&.value
  end

  def has?(key)
    !@buckets[hash_index(key)].find(key).nil?
  end

  def remove(key)
    key_index = hash_index(key)
    removed_node = @buckets[key_index].remove(key)
    @count -= 1 unless removed_node.nil?
    removed_node
  end

  # checking if the load capacity is greater than MAX_LOAD_CAPACITY
  def high_load_capacity
    @count.to_f / @buckets.size > MAX_LOAD_CAPACITY
  end

  # Resize the buckets and copy from old linked-list to new linked-list
  def resize
    old_buckets = @buckets
    @buckets = Array.new(old_buckets.size * 2) { LinkedList.new }
    old_buckets.each do |bucket|
      current_node = bucket.head
      while current_node
        new_index = hash_index(current_node.key)
        @buckets[new_index].append(current_node.key, current_node.value)
        current_node = current_node.next_node
      end
    end
  end

  # hashing function
  def my_hash(key)
    hash_code = 0
    prime_number = 31
    key.each_char { |char| hash_code = hash_code * prime_number + char.ord }
    hash_code
  end

  # creating indexes using the hashing function
  def hash_index(key)
    index = my_hash(key) % @buckets.size
    raise IndexError if index.negative? || index >= @buckets.size

    index
  end
end
