class_name State
extends Node

# Node name is state name

var transitions := {}
func _ready():
    var valid_transitions = _recursively_get_transitions_from_children()
    print(valid_transitions)
    for transition in valid_transitions:
        transitions[transition.name] = transition

func on_entry():
    pass
func on_process():
    pass
func on_exit():
    pass

func _recursively_get_transitions_from_children():
    var node_queue := get_children()
    var state_transitions := []

    while node_queue.size() > 0:
        var node = node_queue.pop_front()
        if node is Transition:
            state_transitions.append(node)
        else:
            node_queue.append_array(node.get_children())

    return state_transitions