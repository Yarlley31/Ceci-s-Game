extends State
class_name HurtState

@onready var state_machine : Node = get_parent()

@export var knockback_duration: float = 0.25
@export var knockback_force: Vector2 = Vector2(200, -200)

var knockback_timer: float = 0.0
var direction: float = 1.0  

func enter() -> void:
	knockback_timer = knockback_duration
	player.is_in_knockback_state = true
	player.velocity = knockback_force * direction
	player.anim.modulate = Color(1, 0, 0, 1)

func exit() -> void:
	player.is_in_knockback_state = false
	player.anim.modulate = Color(1, 1, 1, 1)

func handle_input(event: InputEvent) -> State:
	return null 
	
func physics_update(delta: float) -> State:
	if not player.is_on_floor():
		player.velocity += player.get_gravity() * delta

	player.position += player.velocity * delta

	knockback_timer -= delta
	if knockback_timer <= 0:
		return state_machine.previous_state  
		
	return null
