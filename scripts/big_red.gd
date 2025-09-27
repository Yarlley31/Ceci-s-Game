extends CharacterBody2D

const SPEED : float = 1000.0
const JUMP_VELOCITY : float = -400.0

@onready var touch_detector := $touch_detector as RayCast2D
@onready var animation := $AnimatedSprite2D as AnimatedSprite2D

@export var enemy_score : int = 100

var is_hurting : bool = false
var direction : int = -1

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if touch_detector.is_colliding():
		direction *= -1
		touch_detector.scale.x *= -1
	
	if not is_hurting:
		if direction == 1:
			animation.scale.x = -1
			animation.play("walk")
		else:
			animation.scale.x = 1
			animation.play("walk")
		
		
		velocity.x = direction * SPEED * delta

	move_and_slide()

func _on_animated_sprite_2d_animation_finished() -> void:
	#if animation.name == "hurt":
	queue_free()

func playhurt() -> void:
	if is_hurting:
		return
	is_hurting = true
	Globals.score += enemy_score
	animation.play("hurt")
	velocity = Vector2.ZERO
