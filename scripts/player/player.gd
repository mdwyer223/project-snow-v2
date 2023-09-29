extends CharacterBody2D
class_name Player

@onready var _animated_sprite = $animated_sprite

var speed = 300

# The last known direction of the character
var direction: String = Constants.DIRECTION_SOUTH
var velocity_from_input = Vector2.ZERO

# This can be expanded to be more than moving, like running, walking, or crawling
var moving: bool = false

# Controls if the player has four directions or eight directions for their animations
var four_directional: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	velocity_from_input = _handle_input()
	
	if velocity_from_input.length() > 0:
		moving = true
	else: 
		moving = false

	self.z_index = int(self.position.y)
	
	_handle_direction(velocity_from_input)
	_handle_animation()
	
func _physics_process(delta):
	move_and_collide(velocity_from_input * delta)
	
func _handle_input():
	var input_velocity = Vector2.ZERO
	
	input_velocity.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_velocity.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	input_velocity = input_velocity.normalized() * speed
	return input_velocity
	
func _handle_direction(input_velocity: Vector2):
	var directions = []
	if input_velocity.y > 0:
		directions.append(Constants.DIRECTION_SOUTH)
	elif input_velocity.y < 0:
		directions.append(Constants.DIRECTION_NORTH)
	
	if input_velocity.x > 0:
		directions.append(Constants.DIRECTION_EAST)
	elif input_velocity.x < 0: 
		directions.append(Constants.DIRECTION_WEST)
	
	var num_directions = len(directions)
	if num_directions > 0:
		if four_directional:
			direction = directions[0] if num_directions == 1 else directions[1]
		else:
			direction = directions[0] if num_directions == 1 else "%s_%s" % directions
	

func _handle_animation():
	var animation_type: String = "idle" if not moving else "walk"
	var animation: String = "%s_%s" % [animation_type, direction]
	_animated_sprite.play(animation)
