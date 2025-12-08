extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal transition_finished(anim_name)

func player_anim(anim_name : String) -> void:
	animation_player.play(anim_name)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	emit_signal("transition_finished", anim_name)
	
