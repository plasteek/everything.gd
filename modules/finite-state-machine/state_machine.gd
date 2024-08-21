class_name StateMachine
extends Node

var valid_states := {}
var current_state: State

func _ready():
   var states = _recursively_get_states_from_children()
   if states.size() <= 0:
      push_error("State Machine does not have any state")
      return

   # Gather all states the state machine (has to be first to know all states)
   for state in states:
      valid_states[state.name] = state
   for state in states:
      _validate_state_transition_target(state)

   # Assume first node is the first state
   current_state = states[0]
   current_state.on_entry()

func transition(event_name: String):
   var state_transitions = current_state.transitions
   if not event_name in state_transitions:
      push_error("'%s' cannot handle the event/signal '%s'" % [current_state.name, event_name])
      return

   var on_going_transition: Transition = state_transitions[event_name]
   if not on_going_transition.should_transition():
      return
   
   var target_state = valid_states[on_going_transition.target_state]

   current_state.on_exit()
   current_state = target_state # Set the transition early to allow recursive transition

   on_going_transition.on_transition()
   current_state.on_entry()
   await current_state.on_process()


func _validate_state_transition_target(state: State):
   for t in state.transitions.values():
      var is_target_valid = valid_states.has(t.target_state)
      if not is_target_valid:
         push_error("Invalid target for t in state '%s' in signal '%s' with the target of '%s'" % [state.name, t.name, t.target_state])

func _recursively_get_states_from_children():
   var node_queue := get_children()
   var states := []

   while node_queue.size() > 0:
      var node = node_queue.pop_front()
      if node is State:
         states.append(node)
      else:
         node_queue.append_array(node.get_children())

   return states