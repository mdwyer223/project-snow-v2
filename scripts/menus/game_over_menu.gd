extends CanvasLayer
class_name GameOverMenu


func _ready():
	add_to_group(Constants.MENU_GROUP_NAME)

# The intention here is to get the latest auto save or save state that the
# player has and load it
func _on_continue_button_pressed():
	Events.load_game.emit(null)
	
# This will most likely spawn another menu that can search for save states
# that the player has
func _on_load_game_button_pressed():
	Events.load_game.emit(null)

func _on_main_menu_button_pressed():
	Events.load_main_menu.emit()

func _on_exit_game_button_pressed():
	Events.exit_game.emit()
