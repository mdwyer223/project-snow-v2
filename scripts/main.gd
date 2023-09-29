extends Node
class_name Main

@onready var gui = $GUI
@onready var world = $World

var game_state: Enums.GameState = Enums.GameState.RUNNING

const main_menu_scene_packed = preload("res://scenes/menus/main_menu.tscn")

# Used to change the world scene in the main program
func change_world_scene(scene):
	world.add_child(scene)
	
func change_game_state(new_state: Enums.GameState):
	print_debug(new_state)
	var old_state = game_state
	
	if new_state == Enums.GameState.PAUSED:
		_pause_game()
	elif new_state == Enums.GameState.RUNNING:
		_resume_game()
		
	game_state = new_state

func _pause_game():
	var pause_menu_scene = preload("res://scenes/menus/pause_menu.tscn").instantiate()
	
	pause_menu_scene.resume_game.connect(_on_resume_game_emitted)
	pause_menu_scene.exit_game.connect(_on_exit_game_emitted)
	
	gui.add_child(pause_menu_scene)
	world.get_tree().paused = true
	
func _resume_game():
	var pause_menu = gui.get_node("PauseMenu")
	gui.remove_child(pause_menu)
	world.get_tree().paused = false
	
	
func _exit_game():
	get_tree().quit()

func _input(event):
	print("catching input")
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			if game_state == Enums.GameState.RUNNING:
				change_game_state(Enums.GameState.PAUSED)
			else:
				change_game_state(Enums.GameState.RUNNING)


func _ready():
	var main_menu_scene = main_menu_scene_packed.instantiate()
	
	main_menu_scene.load_game.connect(_on_load_game_emitted)
	main_menu_scene.exit_game.connect(_on_exit_game_emitted)
	
	gui.add_child(main_menu_scene)
	
func _instantiate_player(game_data):
	var player = preload("res://scenes/players/player.tscn").instantiate()
	world.add_child(player)
	
func _instantiate_pause_menu(game_data):
	pass
	
func _load_game(game_data):
	for child in gui.get_children():
		gui.remove_child(child)
	
	# load game data from disk, then apply to each of the objects
	var edies_house = preload("res://scenes/areas/dwyegrove/house_edie.tscn").instantiate()
	change_world_scene(edies_house)
	
	_instantiate_pause_menu(game_data)
	_instantiate_player(game_data)
	
# Need something here to handle loading the game and spawning characters and everything
# Not exactly sure what that looks like, we will hold this here for now
func _on_load_game_emitted(game_data):
	_load_game(game_data)
	
func _on_resume_game_emitted():
	change_game_state(Enums.GameState.RUNNING)
	
func _on_pause_game_emitted():
	_pause_game()

func _on_exit_game_emitted():
	_exit_game()
