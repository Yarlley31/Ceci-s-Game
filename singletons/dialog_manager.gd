extends Node

@onready var mensage_box_scene = preload("res://prefabs/mensage_box.tscn")

var mensage_lines : Array[String] = []
var current_line = 0

var dialog_box
var dialog_box_positon := Vector2.ZERO

var is_mensage_active := false
var can_advance_mensage := false

func start_mensage(possiton: Vector2, lines: Array[String]):
	if is_mensage_active:
		return
	
	mensage_lines = lines
	dialog_box_positon = possiton
	show_text()
	is_mensage_active = true
	
func show_text():
	dialog_box = mensage_box_scene.instantiate()
	dialog_box.text_display_finished.connect(_on_all_text_displayed)
	get_tree().root.add_child(dialog_box)
	dialog_box.global_position = dialog_box_positon
	dialog_box.display_text(mensage_lines[current_line])
	can_advance_mensage = false

func _on_all_text_displayed():
	can_advance_mensage = true
	
func _unhandled_input(event: InputEvent) -> void:
	if(event.is_action_pressed("advance_message") && is_mensage_active && can_advance_mensage):
		dialog_box.queue_free()
		current_line += 1
		if current_line >= mensage_lines.size():
			is_mensage_active = false
			current_line = 0
			return
		show_text()
