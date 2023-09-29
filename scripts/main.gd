extends Node
class_name Main

@onready var gui = $GUI
@onready var world: World = $World

var game_state: Constants.GameState = Constants.GameState.MENU

const main_menu_scene_packed = preload("res://scenes/menus/main_menu.tscn")

# Used to change the world scene in the main program
func change_world_scene(scene):
	world.add_child(scene)
	
func change_game_state(new_state: Constants.GameState):
	var _old_state = game_state
	
	if new_state == Constants.GameState.PAUSED:
		_pause_game()
	elif new_state == Constants.GameState.RUNNING:
		_resume_game()
		
	game_state = new_state

func _pause_game():
	var pause_menu_scene = preload("res://scenes/menus/pause_menu.tscn").instantiate()
	
	gui.add_child(pause_menu_scene)
	world.get_tree().paused = true
	
func _resume_game():
	for node in gui.get_tree().get_nodes_in_group(Constants.MENU_GROUP_NAME):
		gui.remove_child(node)
	
	world.get_tree().paused = false

func _exit_game():
	get_tree().quit()

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			if game_state == Constants.GameState.RUNNING:
				change_game_state(Constants.GameState.PAUSED)
			else:
				change_game_state(Constants.GameState.RUNNING)


func _ready():
	# Connect signals
	Events.load_game.connect(_on_load_game_emitted)
	Events.resume_game.connect(_on_resume_game_emitted)
	Events.pause_game.connect(_on_pause_game_emitted)
	Events.exit_game.connect(_on_exit_game_emitted)
	
	var main_menu_scene = main_menu_scene_packed.instantiate()
	gui.add_child(main_menu_scene)
	
func _instantiate_player(_game_data):
	var player: Player = preload("res://scenes/players/player.tscn").instantiate()
	world.add_child(player)
	world.set_player(player)
	
func _instantiate_pause_menu(_game_data):
	pass
	
func _load_game(game_data):
	# Update the game state
	change_game_state(Constants.GameState.RUNNING)

	# load player and pause menu
	_instantiate_pause_menu(game_data)
	_instantiate_player(game_data)
	
	# load game data from disk, then apply to each of the objects
	var edies_house = preload("res://scenes/areas/dwyegrove/house_edie.tscn").instantiate()
	change_world_scene(edies_house)
	
# Need something here to handle loading the game and spawning characters and everything
# Not exactly sure what that looks like, we will hold this here for now
func _on_load_game_emitted(game_data):
	_load_game(game_data)
	
func _on_resume_game_emitted():
	change_game_state(Constants.GameState.RUNNING)
	
func _on_pause_game_emitted():
	change_game_state(Constants.GameState.PAUSED)

func _on_exit_game_emitted():
	_exit_game()
