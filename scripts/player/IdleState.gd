extends State
class_name IdleState

@onready var state_machine : Node = get_parent()

func enter() -> void:
	print("idle")
	player.anim.play("idle")
	player.reset_jump_count()
	
func handle_input(event: InputEvent) -> State:
	if event.is_action_pressed("jump"):
		if player.is_on_floor():
			player.jump()
			return state_machine.get_node("jump")
		else:
			player.start_jump_buffer()
	return null
	
func physics_update(delta: float) -> State:
	var input_axis : float = Input.get_axis("left", "right")
	player.move(delta, input_axis)
	
	if player.is_on_floor() and player.is_jump_buffering():
		player.stop_jump_buffer()
		player.jump()
		return state_machine.get_node("jump")
		
	if input_axis != 0 and player.is_on_floor():
		return state_machine.get_node("walk")
		
	if player.velocity.y > 0:
		return state_machine.get_node("fall")
		
	return null
