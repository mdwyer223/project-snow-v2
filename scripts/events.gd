extends Node

### Menu signals
signal resume_game
signal load_game(game_data)
signal pause_game
signal exit_game
signal options

### World signals
signal focus_camera(target: Node2D)
signal focus_camera_on_player
signal move_player(target: Vector2)