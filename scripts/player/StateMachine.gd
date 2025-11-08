extends Node
class_name StateMachine

@export var initial_state: NodePath

var previous_state : State
var current_state : State
var states: Array[State] = []

	
func init(p_player: CharacterBody2D) -> void:
	for child in get_children():
		if child is State:
			child.player = p_player
			child.state_machine = self
			states.append(child)

	if initial_state:
		var start_state = get_node(initial_state)
		transition_to(start_state)

	
func handle_input(event: InputEvent) -> void:
	if current_state:
		var new_state = current_state.handle_input(event)
		if new_state:
			transition_to(new_state)

func physics_update(delta: float) -> void:
	if current_state:
		var new_state = current_state.physics_update(delta)
		if new_state:
			transition_to(new_state)

func transition_to(new_state: State) -> void:
	if current_state:
		current_state.exit()
	previous_state = current_state
	current_state = new_state
	current_state.enter()
