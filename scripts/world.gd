extends Node2D
class_name World


@onready var main_camera: Camera2D = $MainCamera
var camera_speed = 10
var camera_target: Node2D = null

var player: Player = null;

func set_player(new_player: Player):
	print_debug(self.get_tree())
	player = new_player

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.focus_camera_on_player.connect(_on_focus_camera_on_player_emitted)
	Events.focus_camera.connect(_on_focus_camera_emitted)
	Events.move_player.connect(_on_move_player)

	main_camera.position_smoothing_enabled = true
	main_camera.position_smoothing_speed = camera_speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if camera_target:
		main_camera.position = camera_target.position

func _on_focus_camera_on_player_emitted():
	self.camera_target = player

func _on_focus_camera_emitted(new_target: Node2D):
	self.camera_target = new_target

func _on_move_player(new_position: Vector2):
	player.position = new_position