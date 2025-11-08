extends State
class_name FallState

@onready var state_machine : Node = get_parent()

func enter() -> void:
	player.anim.play("fall")

func handle_input(event: InputEvent) -> State:
	if event.is_action_pressed("jump"):
		player.start_jump_buffer()
	
	return null

func physics_update(delta: float) -> State:
	player.move(delta, Input.get_axis("left", "right"))
	
	if player.is_on_floor():
		player.stop_jump_buffer()
		return state_machine.get_node("idle")
	
	return null
