extends Area2D

@export var speed: int = 400
var direction: Vector2 = Vector2.UP

func _process(delta):
	pass
	position += direction * speed * delta
# Called when the node enters the scene tree for the first time.
