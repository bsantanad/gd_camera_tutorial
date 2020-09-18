extends Node
class_name State, "res://assets/2d/icons/state.svg"

onready var _state_machine =  _get_state_machine(self)


var _parent: State = null

func _ready() -> void:
	# Wait until the owner node (In this case Game) it's ready, then continue
	yield(owner, "ready") 
	# If we don't wait, godot will try to do this node before his parent
	var parent = get_parent()
	# We check if the parent is a State, we dont want to have the StateMachine
	# as a parent
	if not parent.is_in_group("state_machine"):
		_parent = parent

func unhandled_input(event: InputEvent) -> void:
	return

func process(delta: float) -> void:
	return

func physics_process(delta: float) -> void:
	return


func enter(msg: = {}) -> void:
	return
	
func exit() -> void:
	return

# Recursive function, It start at some State node, and go on until it finds
# the state machine. The node != null, it's to prevent a bug, if we forget 
# to add the state_machine group
func _get_state_machine(node: Node) -> Node:
	if node != null and not node.is_in_group("state_machine"):
		return _get_state_machine(node.get_parent()) 
	return node
