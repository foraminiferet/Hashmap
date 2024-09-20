# frozen_string_literal: true

# Linked list fore each bucket and calision checking
class LinkedList
  attr_accessor :head

  def initialize
    @head = nil
  end

  Node = Struct.new(:key, :value, :next_node)

  def append(key, value)
    new_node = Node.new(key, value)

    if head.nil?
      self.head = new_node
    else
      current_node = head
      current_node = current_node.next_node while current_node.next_node
      current_node.next_node = new_node
    end
  end

  def remove(key) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    return nil if head.nil?

    if head.key == key
      removed_node = head
      self.head = head.next_node
      return removed_node.value
    end

    current_node = head

    while current_node.next_node
      if current_node.next_node.key == key
        removed_node = current_node.next_node
        current_node.next_node = current_node.next_node.next_node
        return removed_node.value
      end
      current_node = current_node.next_node
    end
    nil
  end

  def find(key)
    current_node = head
    while current_node
      return current_node if current_node.key == key

      current_node = current_node.next_node
    end
    nil
  end
end
