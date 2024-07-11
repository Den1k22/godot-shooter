extends Area2D
class_name Item

var rotation_speed: int = 5
var available_options = ["laser", "laser", "laser", "laser", "grenade", "health"]
var type = available_options[randi() % len(available_options)]

func _ready():
	match type:
		"laser": $Sprite2D.modulate = Color(Color.BLUE)
		"grenade": $Sprite2D.modulate = Color(Color.RED)
		"health": $Sprite2D.modulate = Color(Color.GREEN)

func _process(delta):
	rotation += rotation_speed * delta


func _on_body_entered(_body):
	match type:
		"laser": Globals.laser_amount += 5
		"grenade": Globals.grenade_amount += 1
		"health": Globals.health += 10
	queue_free()
