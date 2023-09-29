extends CanvasLayer

signal resume_game
signal load_game
signal exit_game

func _on_resume_game_button_pressed():
	resume_game.emit()

func _on_load_game_button_pressed():
	load_game.emit()
	
func _on_options_button_pressed():
	pass

func _on_exit_game_button_pressed():
	exit_game.emit()
