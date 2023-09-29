extends CanvasLayer
class_name PauseMenu


func _ready():
	add_to_group(Constants.MENU_GROUP_NAME)

func _on_resume_game_button_pressed():
	Events.resume_game.emit()

func _on_load_game_button_pressed():
	Events.load_game.emit(null)
	
func _on_options_button_pressed():
	Events.options.emit()

func _on_exit_game_button_pressed():
	Events.exit_game.emit()
