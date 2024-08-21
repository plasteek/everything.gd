<p align="center">
    <h1 align="center">Data Structures Collection</h1>
    <p align="center">Common Data Structures or Safer Class Wrapper not Present in Godot (4.2+)</p>
</p>

# Introduction

This category contains commonly used data structures that are either a wrapper class (often to dictionary) or just non implemented in Godot.

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
