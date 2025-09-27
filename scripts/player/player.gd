extends CharacterBody2D


const SPEED : int = 300.0
const jump_force : float = -350.0

var is_jumping : bool = false
var is_in_knockback_state : bool = false

@onready var animation := $AnimatedSprite2D as AnimatedSprite2D
@onready var remote_transform := $remote as RemoteTransform2D

signal player_has_died()

var knockback_vector := Vector2.ZERO

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if not is_in_knockback_state:
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = jump_force
			is_jumping = true
		elif is_on_floor():
			is_jumping = false

		var direction := Input.get_axis("left", "right")
		if direction:
			velocity.x = direction * SPEED
			animation.scale.x = direction
			if !is_jumping:
				animation.play("runing")
		else:	
			velocity.x = move_toward(velocity.x, 0, SPEED)
			animation.play("idle")
		if is_jumping:
			animation.play("jump")
			
		if knockback_vector != Vector2.ZERO:
			velocity = knockback_vector
			
	move_and_slide()
	
func _on_hurtbox_body_entered(body: Node2D) -> void:
	#if body.is_in_group("enemies"):
		#queue_free()
	#if player_life < 0:
		#queue_free()
	
	if $ray_right.is_colliding():
		take_damage(Vector2(200, -200))
	else:
		take_damage(Vector2(-200, -200))
		
func follow_camera(camera):
	var camera_path = camera.get_path()
	remote_transform.remote_path = camera_path
	
func take_damage(knockback_force := Vector2.ZERO, duration :float = .25):
	if Globals.player_life>0:
		Globals.player_life -= 1
	else:
		queue_free()
		emit_signal("player_has_died")
	
	if knockback_force != Vector2.ZERO:
		is_in_knockback_state = true
		velocity = knockback_force

		var knockback_tween := get_tree().create_tween()
		knockback_tween.parallel().tween_property(self, "is_in_knockback_state", false, duration)
		
		animation.modulate = Color(1,0,0,1)
		knockback_tween.parallel().tween_property(animation, "modulate", Color(1,1,1,1), duration)
		
