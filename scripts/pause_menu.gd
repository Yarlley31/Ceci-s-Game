extends CanvasLayer


@export var resume_btn: Button 


func _ready() -> void:
	visible = false

func _process(delta: float) -> void:
	pass
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		visible = !visible 
		get_tree().paused = visible
		
		if visible:
			resume_btn.grab_focus()

func _on_resume_btn_pressed() -> void:
	get_tree().paused = false
	visible = false

func _on_select_level_btn_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/world_select/world_select.tscn")
	
func _on_quit_btn_pressed() -> void:
	get_tree().quit()
