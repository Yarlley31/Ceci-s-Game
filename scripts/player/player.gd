extends CharacterBody2D
class_name Player

# Constantes de Movimento
const SPEED : int = 200.0
const JUMP_FORCE : float = -300.0

# Variaveis de Estado
var is_in_knockback_state : bool = false
var is_on_ground : bool = false
var _is_jump_buffering: bool = false

# Variaveis para o Pulo
const JUMP_BUFFER_TIME : float = 0.1
var jump_buffer_timer : float = 0.0

# Referencias
@onready var anim := $AnimatedSprite2D as AnimatedSprite2D
@onready var remote_transform := $remote as RemoteTransform2D
@onready var state_machine = $StateMachine

# Variaveis de Vida
@export var player_life : int = 10
signal player_has_died()

func _ready():
	state_machine.init(self)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	is_on_ground = is_on_floor()
	
	if not is_in_knockback_state:
		state_machine.physics_update(delta)
	
	if _is_jump_buffering:
		jump_buffer_timer -= delta
		if jump_buffer_timer <= 0:
			_is_jump_buffering = false

	move_and_slide()


func _input(event: InputEvent) -> void:
	if not is_in_knockback_state:
		state_machine.handle_input(event)


func move(delta: float, direction: float) -> void:
	var acceleration : float = 2000.0
	var friction : float = 3000.0

	if direction != 0:
		velocity.x = move_toward(velocity.x, direction * SPEED, acceleration * delta)
		anim.scale.x = direction
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)

	
func jump() -> void:
	if is_on_floor() or is_jump_buffering():
		velocity.y = JUMP_FORCE
		stop_jump_buffer()

func can_jump() -> bool:
	return is_on_floor()
	
func is_jump_buffering() -> bool:
	return _is_jump_buffering

func start_jump_buffer() -> void:
	_is_jump_buffering = true
	jump_buffer_timer = JUMP_BUFFER_TIME
	
func stop_jump_buffer() -> void:
	_is_jump_buffering = false
	jump_buffer_timer = 0.0

func reset_jump_count():
	pass

func follow_camera(camera):
	remote_transform.remote_path = camera.get_path()
	
func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"): 
		if $ray_right.is_colliding():
			take_damage(Vector2(200, -200))
		else:
			take_damage(Vector2(-200, -200))


func take_damage(knock_dir := Vector2.ZERO):
	Globals.player_life -= 1
	
	if player_life <= 0:
		queue_free()
		emit_signal("player_has_died")
		return
	
	# with a bug here!
	
	#var hurt_state = state_machine.get_node("Hurt")
	#if knock_dir.x < 0:
	#	hurt_state.direction = -1
	#else:
	#	hurt_state.direction = 1
	#state_machine.transition_to(hurt_state)
			
