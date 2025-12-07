extends Control

@onready var worlds : Array = [$worldIcon, $worldIcon2, $worldIcon3, $worldIcon4, $worldIcon5]
var current_world : int = 0
var move_tween: Tween

func _ready():
	$PlayerIcon.global_position = worlds[current_world].global_position

func _input(event):
	if move_tween and move_tween.is_running():
		return
		
	if event.is_action_pressed("left") and current_world > 0:
		current_world -= 1
		tween_icon()
		
	if event.is_action_pressed("right") and current_world < worlds.size() -1:
		current_world += 1
		tween_icon()
		
	if event.is_action_pressed("accept"):
		if worlds[current_world].level_select_scene:
			worlds[current_world].level_select_scene.parent_world_select = self
			get_tree().get_root().add_child(worlds[current_world].level_select_scene)
			get_tree().current_scene = worlds[current_world].level_select_scene
			get_tree().get_root().remove_child(self)

func tween_icon():
	move_tween = get_tree().create_tween()
	move_tween.tween_property($PlayerIcon, "global_position", worlds[current_world].global_position, 0.5).set_trans(Tween.TRANS_SINE)
