extends Node2D

@onready var player_start_position: Node2D = $PlayerStartPosition
@onready var map: TileMap = $TileMap

func _ready():	
	Events.focus_camera_on_player.emit()
	Events.move_player.emit(player_start_position.position)
