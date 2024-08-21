<p align="center">
    <h1 align="center">Algorithms Collection</h1>
    <p align="center">An assortment of traditional computer science algorithms. Probably used as a reference since most of them are often not used in game development</p>
</p>

# Introduction

Contains algorithms that you might need for path-finding or some other general shit.

# Dijkstra Path-finding

Implementation of the dijkstra algorithm with general abstraction.

```gdscript
# start node signifies the node it starts on
# get_connection accepts a param of `current_node_id` and should
# return an array of connection for the said node using `Dijkstra.connection`
Dijkstra.find_shortest_paths(start_node_id, get_connections)
Dijkstra.connection(target_id, distance) # Defines a connection
```

The implementation purposefully allows ANY node classes for flexibility.

## Full Example

```gdscript
extends Node2D

func _ready() -> void:
   var g = {
      0: {
         1: 4,
         7: 8,
      },
      1: {
         2: 8,
         7: 11,
      },
      2: {
         3: 7,
         5: 4,
         8: 2,
      },
      3: {
         4: 9,
         5: 14,
      },
      4: {},
      5: {
         3: 14,
         4: 10,
      },
      6: {
         5: 2,
         8: 6,
      },
      7: {
         1: 11,
         6: 1,
         8: 7,
      },
      8: {
         2: 2,
         6: 6
      }
   }
   var res = Dijkstra.find_shortest_paths(0, func(id): return turn_to_conn(g[id]))
   print(res)

func turn_to_conn(conns: Dictionary):
   var all_conn = []
   for target in conns.keys():
      var distance = conns[target]
      all_conn.append(Dijkstra.connection(target, distance))
   return all_conn
```
