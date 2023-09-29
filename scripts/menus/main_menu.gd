extends CanvasLayer
class_name MainMenu


func _ready():
	add_to_group(Constants.MENU_GROUP_NAME)

func _on_continue_game_button_pressed():
	Events.load_game.emit(null)

# Open another menu, and allow it to emit the signal from the child
func _on_load_game_button_pressed():
	Events.load_game.emit(null)

func _on_new_game_button_pressed():
	Events.load_game.emit(null)

# Similar to load game
func _on_options_button_pressed():
	Events.options.emit()
	
func _on_exit_game_button_pressed():
	Events.exit_game.emit()
