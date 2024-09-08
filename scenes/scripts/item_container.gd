extends Node2D
class_name ItemContainer

@onready var current_diretion: Vector2 = Vector2.DOWN.rotated(rotation)
var opened: bool = false
signal open(pos, direction)

func hit():
	open.emit(null, null)
