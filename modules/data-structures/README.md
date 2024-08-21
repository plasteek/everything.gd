<p align="center">
    <h1 align="center">Data Structures Collection</h1>
    <p align="center">Common Data Structures or Safer Class Wrapper not Present in Godot (4.2+)</p>
</p>

# Introduction

This category contains commonly used data structures that are either a wrapper class (often to dictionary) or just non implemented in Godot.

# Priority Queue / Binary Heap

A data structure that ensures the first element is always the largest (max-heap) or the smallest (min-heap) item. This implementation uses a non-recursive variant for max efficiency

```gdscript
var pq = PriorityQueue.new(
    # Initial heap elements
    [3, 2, 1, 1, 2, 3, 199, 1, 2000],
    # MAX_HEAP = largest item is at the top (default)
    # MIN_HEAP = smallest item is at the top
    # You may also specify a custom compare function that takes 2
    # integer as params, a and b
    Priority.MAX_HEAP,
    # "weight" function, if your heap is comprised on non-integers
    # such as class, this function is used to extract the "value"
    # or priority you want to assign to the class
    func (a): a
)

pq.insert(1000)
var popped = pq.pop()
var peeked = pq.peek() # Does not remove
pq.size()
```

# Set

A collection of unique items (an array without duplicates).
_NOTE_: the item can be object or classes and not just primitive data types.

```gdscript
var set = Set.new()

set.add("example") # If there are duplicate, it would simply return and not add it to the set
set.add_array(["item 1", "item 2"])

set.remove("item name")
set.has("item")

set.size()
set.values()

set.equal(some_other_set) # Checks if the current set contains the same items as the one provided
set.union(some_other_set) # Merges the 2 set into the current one
set.clone()

Set.unique([1 ,1, 2, 3]) # [1, 2, 3]
Set.from_array([1, 1, 2, 3]) # Set([1, 2, 3])
```

# Map

A wrapper around dictionary, more commonly known as HashMap in python. The goal is to emphasize safety and not accessing non-existent keys by accident

```gdscript
var map - Map.new()

map.set_value("key", "some value here")
map.get_value("key") # Pushes error if key does not exist
map.delete("key")

map.has("key")
map.size()

map.keys()
map.values()

map.get_dict() # Get the internal dictionary used in map
map.clone()

# From all the map, search the first occurrence of the key
# If the key does not exist, then return null
Map.search_all([map, map, map])
```

# Stack

A simple stack. Literally nothing else.

```gdscript
var stack = Stack.new()

stack.push(item)
stack.pop()

stack.insert(item, offset_from_top) # From top defaults to zero

stack.top() # Returns the top element of the stack
stack.size()
```
