extends MarginContainer

@onready var mensage_label: Label = $label_margin/mensage_label
@onready var letter_timer_display: Timer = $letter_timer_display

const MAX_WIDTH : int = 256

var text : String = ""
var letter_index : int = 0

var letter_display_timer : float = 0.07
var space_display_timer : float = 0.05
var punctuation_display_timer : float = 0.2

signal text_display_finished()

func display_text(text_to_display : String):
	size.x = 0 
	size.y = 0
	text = text_to_display
	mensage_label.text = text_to_display
	
	await resized
	custom_minimum_size.x  = min(size.x, MAX_WIDTH)
	
	if size.x > MAX_WIDTH:
		mensage_label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized
		await resized
		custom_minimum_size.y = size.y
		
	global_position.x -= size.x / 2
	global_position.y -= size.y + 24
	mensage_label.text = ""
	
	display_letter()
	
func display_letter():
	mensage_label.text += text[letter_index]
	letter_index += 1
	
	if letter_index >= text.length():
		text_display_finished.emit()
		return
	
	match text[letter_index]:
		"!", "?", ",", ".":
			letter_timer_display.start(punctuation_display_timer)
		" ":
			letter_timer_display.start(space_display_timer)
		_:
			letter_timer_display.start(letter_display_timer)
	

func _on_letter_timer_display_timeout() -> void:
	display_letter()
