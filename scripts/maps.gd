extends Node2D
class_name Maps

static var direction_map: Dictionary  = {
    0: "down",
    1: "up",
    2: "left",
    3: "right"
}

static func get_direction_string(direction: Enums.Direction):
    return direction_map.get(direction)