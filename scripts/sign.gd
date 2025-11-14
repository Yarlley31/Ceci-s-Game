extends Node2D

@onready var texture: Sprite2D = $texture
@onready var area_sing: Area2D = $area_sign

const lines : Array[String] = ["Fase 2"]

func _unhandled_input(event: InputEvent) -> void:
	if area_sing.get_overlapping_bodies().size() > 0:
		texture.show()
		if event.is_action_pressed("interact") && !DialogManager.is_mensage_active:
			texture.hide()
			DialogManager.start_mensage(global_position, lines)
	else:
		texture.hide()
		if DialogManager.dialog_box != null:
			DialogManager.dialog_box.queue_free()
			DialogManager.is_mensage_active = false
