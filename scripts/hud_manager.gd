extends Control

@onready var coins_counter: Label = $container/coins_container/coins_counter as Label
@onready var score_counter: Label = $container/score_container/score_counter as Label
@onready var life_counter: Label = $container/life_container/life_counter as Label


func _ready() -> void:
	coins_counter.text = str("%04d" % Globals.coins)
	score_counter.text = str("%06d" % Globals.score)
	life_counter.text = str("%02d" % Globals.player_life)

func _process(delta: float) -> void:
	coins_counter.text = str("%04d" % Globals.coins)
	score_counter.text = str("%06d" % Globals.score)
	life_counter.text = str("%02d" % Globals.player_life) 
