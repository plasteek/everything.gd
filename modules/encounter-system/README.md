<p align="center">
    <h1 align="center"> ZZZ-ish Encounter System</h1>
    <p>Zen-less Zone Zero inspired encounter system written in Godot (4.2+)</p>
</p>

## Setup

1. Add `EncounterPlayer` to your scene
2. Write an `Encounter` and link it to the player
3. Handle the signals in `EncounterPlayer` to properly handle event handing

## Writing an Encounter

An `Encounter` is a node hat contains the encounter description and options. You will have to extend the base `Encounter`
class and override `get_encounter` lifecycle to work with the player later on

### Functions

-  `event(event_description_or_character_dialog: String, options: Dictionary<OptionText, Event|Action>, callback_on_event_enter: Callable)`: Creates an event or a dialog panel for the use to select
-  `action(callback: Array[Callable] | Callable, reset_on_callback = false)`: Creates an action where the option simply calls the specified function and nothing more. This is often paired using `EncounterPlayer` for additional navigation functionality.

### Example:

```GDScript
extends Encounter
@export var encounter: EncounterPlayer # Reference encounter player to enable navigation features

func get_encounter():
   var example_option_b = event(
      "Some very creative description",
      {
         "Test Action": action(some_encounter_action, true),
         "Test Back": event(
            "Testing Back Button",
               {
                  "Back": action(encounter.previous)
               }
         ),
         "Test Reset": event(
            "Testing Reset Here",
               {
                  "Reset": action(encounter.reset)
               }
         )
      },
   )
   return event(
      "Some description",
      {
         "Option A": event("Event after option a", {}, on_event),
         "Option B": example_option_b
      },
   )

func on_event():
   print("Triggered when option a is clicked but is also an event")
func some_encounter_action():
   print("Triggered when the option is clicked")
```

## Setting up `EncounterPlayer`

### Basic Example

```gdscript
extends Node2D

@onready var encounter = $EncounterPlayer
@onready var description = $Description
@onready var optionsContainer = $Options

func _ready():
   encounter.new_event.connect(handle_event) # Re-rendering
   encounter.completed.connect(hide_encounter) # Hide when encounter is completed
   encounter.start()

func handle_event(desc: String, options: Array):
   description.text = desc

   clear_options()
   for option in options:
      var new_button = Button.new()

      new_button.text = option
      new_button.pressed.connect(func(): encounter.next(option))

      optionsContainer.add_child(new_button)

func hide_encounter():
   print("Encounter finish")
func clear_options():
   for child in optionsContainer.get_children():
      optionsContainer.remove_child(child)
      child.queue_free()
```

### Functions

-  `start()`: starts an encounter/initialize it. Useful for hooking up the events and for initial rendering
-  `next(option_text: String)`: go to the next event or action specified in the encounter
-  `previous`: go to previous dialog before the current one
-  `reset`: reset the entire encounter to start

### Signals

-  `init`: initialization of `EncounterPlayer`, emitted when `start` is evoked
-  `new_event(desc: String, options: Array[String])`: emitted when the user selects an option, hence need re-rendering
-  `completed`: emitted when `reset` is called
