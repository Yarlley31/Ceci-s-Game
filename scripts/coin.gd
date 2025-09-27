extends Area2D

@onready var animation := $AnimatedSprite2D as AnimatedSprite2D

var coins : int = 1

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	animation.play("collected")
	await $CollisionShape2D.call_deferred("queue_free") # nao ta ocorrendo a colisão dupla no memomento mas vai que eu adicione moeda e ocorra
	Globals.coins += coins
	print(Globals.coins)

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
