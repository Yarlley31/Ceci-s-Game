extends Area2D

@export_file("*.tscn") var next_level_path: String
@export_file("*.tscn") var world_select_path: String = "res://scenes/world_select/world_select.tscn"

@onready var menu = $level_complete_menu

func _ready():
	menu.visible = false

# Conecte o sinal 'body_entered' do próprio Area2D aqui
func _on_body_entered(body):
	# Verifica se foi o Player que tocou (ajuste o nome se precisar)
	if body.name == "player" or body.is_in_group("player"):
		win_level()

func win_level():
	get_tree().paused = true # Pausa o jogo
	menu.visible = true # Mostra o menu
	

# --- Funções dos Botões (Conecte os sinais 'pressed' aqui) ---

func _on_next_level_btn_pressed():
	get_tree().paused = false
	if next_level_path:
		get_tree().change_scene_to_file(next_level_path)
	else:
		print("Nenhuma próxima fase configurada!")

func _on_level_select_btn_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file(world_select_path)

func _on_quit_btn_pressed():
	get_tree().quit()
