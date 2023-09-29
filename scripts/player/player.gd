extends Area2D
class_name Player

@onready var _animated_sprite = $animated_sprite

var speed = 300
var direction: Enums.Direction = Enums.Direction.DOWN
var moving: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity: Vector2 = _handle_input()
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		moving = true
	else: 
		moving = false

	position += velocity * delta

	_handle_animation()
	
func _handle_input():
	var velocity = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		direction = Enums.Direction.RIGHT
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		direction = Enums.Direction.LEFT
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction = Enums.Direction.DOWN
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		direction = Enums.Direction.UP
		velocity.y -= 1

	return velocity

func _handle_animation():
	var animation_type: String = "idle" if not moving else "walk"
	var animation_direction: String = Maps.get_direction_string(direction)
	var animation: String = "%s_%s" % [animation_type, animation_direction]
	_animated_sprite.play(animation)
