class_name Transition
extends Node

# Node name is event/signal name
# TODO: maybe implement guard only transition

@export var target_state: String = ""

func should_transition() -> bool:
   return true
func on_transition():
   pass