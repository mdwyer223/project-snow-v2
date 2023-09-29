extends CanvasLayer
class_name MainMenu

signal load_game(game_data)
signal options
signal exit_game

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_continue_game_button_pressed():
	load_game.emit(null)

# Open another menu, and allow it to emit the signal from the child
func _on_load_game_button_pressed():
	load_game.emit(null)

func _on_new_game_button_pressed():
	load_game.emit(null)

# Similar to load game
func _on_options_button_pressed():
	options.emit()
	
func _on_exit_game_button_pressed():
	exit_game.emit()
