<p align="center">
    <h1 align="center">Time Helper</h1>
    <p align="center">Collection of Helper Related to Time</p>
</p>

# Introduction

Some utilities made for helping or a nice-to-have to do stuff related with time.

# Debounce

Delays a function if called sequentially. Ensures that the function is called too many times.

```gdscript
extends Node2D

func _ready():
    var debounce = Debounce.new(self, 200) # ms

    # NOTE: if the function is called twice, the first one
    # would be cancelled
    debounce.call_function(func(): print("Hello world"))
    debounce.call_function(func(): print("Hello world2"))
```

# Delay

Just a simple delay node for general purpose.

```gdscript
extends Node2D

func _ready():
    # Initialize
    var delay = Delay.new(self)

    print("something")
    await delay.wait(1200) # ms
    print("something2")
```

# Stopwatch

A class for measuring elapsed time

```gdscript
var stopwatch = Stopwatch.new()

stopwatch.start("example-tag")
# Do something
stopwatch.stop("example-tag")  # Returns the time that has elapsed in ms
```
