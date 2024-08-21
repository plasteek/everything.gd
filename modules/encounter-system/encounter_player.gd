class_name EncounterPlayer
extends Node

# Base class that should be extended with functionality and shit

signal init(event_name: String, sprite: Sprite2D)
signal new_event(desc: String, options: Array) # Options is array of string
signal completed

@export var encounterName: String = ""
@export var encounterSprite: Sprite2D
@export var encounter: Encounter

const EncounterNode = Encounter.EncounterNode
const EncounterNodeType = Encounter.EncounterNodeType

var _states: Array[EncounterNode]
var _root: EncounterNode:
   get:
      return _states[0]
   set(new_val):
      pass # Read only
var _current: EncounterNode:
   get:
      return _states[_states.size() - 1]
   set(new_val): # Read-only var
      pass
var _current_options: Array # Ensure that the index is consistent, this is array of string

func _ready():
   var root = encounter.get_encounter()
   _states = [root]

# Public functions
func start():
   init.emit(encounterName, encounterSprite)
   _render_interface()
func next(chosen_option: String = ""):
   if not chosen_option in _current.options:
      push_error("Out of bound chosen_option index")
      return
   
   var next_candidate = _current.options[chosen_option]

   match (next_candidate.type):
      EncounterNodeType.ACTION:
         next_candidate.callback.call()
         completed.emit()
         
         if next_candidate.reset_after_callback:
            reset()
      EncounterNodeType.EVENT:
         # Let the next candidate be the current
         _states.push_back(next_candidate)
         _current.callback.call()
         _render_interface()
      _:
         push_error("Invalid EncounterNodeType")
func previous():
   if _states.size() <= 1:
      return
   _states.pop_back()
   _render_interface()
func reset():
   _states = [_root]
   _render_interface()

func _render_interface():
   _current_options = _current.options.keys() # sync the options
   new_event.emit(_current.desc, _current_options)