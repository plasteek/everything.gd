class_name Encounter
extends Node

func get_encounter() -> EncounterNode:
   push_error("Encounter is not defined, override get_encounter")
   return EncounterNode.new()

func event(description: String, options := {}, on_event := func(): pass ) -> EncounterNode:
   var node = EncounterNode.new(EncounterNodeType.EVENT)
   node.desc = description
   node.options = options
   node.callback = on_event
   return node
func action(callback = func(): pass , reset_after_callback = false) -> EncounterNode: # Callback is either an array or a calback
   var node = EncounterNode.new(EncounterNodeType.ACTION)
   node.callback = callback if typeof(callback) == TYPE_CALLABLE else func(): _call_seq(callback)
   node.reset_after_callback = reset_after_callback
   return node

func _call_seq(callbacks: Array[Callable]):
   for callback in callbacks:
      callback.call()

enum EncounterNodeType {EVENT, ACTION, INVALID}
class EncounterNode:
   var type: EncounterNodeType

   # If event
   var desc: String
   var options := {} # This should be a dictionary of the nodes

   # If action (but can also be used in event)
   var reset_after_callback := false
   var callback := func(): pass

   func _init(_type := EncounterNodeType.INVALID):
      type = _type