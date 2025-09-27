extends Area2D
@export var pai : CharacterBody2D 

func _on_body_entered(body: Node2D) -> void:
	
	if body.name == "player":
		body.velocity.y = body.jump_force /2
		print("test")
		pai.playhurt()
