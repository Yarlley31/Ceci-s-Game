extends TileMapLayer

@onready var player := $player as CharacterBody2D
@onready var camera := $camera as Camera2D

func _ready() -> void:
	player.follow_camera(camera)
	player.player_has_died.connect(reload_game) 
	Globals.coins = 0
	Globals.score = 0
	Globals.player_life = 3
	Fading.player_anim("fading_out")
	
func reload_game():
	await get_tree().create_timer(1.0).timeout
	get_tree().reload_current_scene()
