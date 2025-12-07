extends Area2D

@onready var animation := $AnimatedSprite2D as AnimatedSprite2D
@export var next_level_path: String = "res://scenes/level02.tscn"
var is_active: bool = false


func _on_body_entered(body: Node2D) -> void:
	if body.name == "player" and !is_active:
		is_active = true
		
		animation.play("activation")
		animation.play("activated")
		
		await animation.animation_finished

		get_tree().change_scene_to_file(next_level_path)
		
	
