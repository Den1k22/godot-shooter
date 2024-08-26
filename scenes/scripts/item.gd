extends Area2D
class_name Item

var rotation_speed: int = 5
var available_options = ["laser", "laser", "laser", "laser", "grenade", "health"]
var type = available_options[randi() % len(available_options)]

var direction: Vector2
var distance: int = randi_range(150, 250)

func _ready():
	match type:
		"laser": $Sprite2D.modulate = Color(Color.BLUE)
		"grenade": $Sprite2D.modulate = Color(Color.RED)
		"health": $Sprite2D.modulate = Color(Color.GREEN)

	var randomized_direction = direction + Vector2(randf_range(-0.5, 0.5), 0)
	var randomized_direction_normalized = randomized_direction.normalized()
	var target_pos = position + randomized_direction_normalized * distance
	#var target_pos = position + direction * distance
	
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position", target_pos, 0.5)
	tween.tween_property(self, "scale", Vector2(1,1), 0.3).from(Vector2(0,0))

func _process(delta):
	rotation += rotation_speed * delta

func _on_body_entered(_body):
	match type:
		"laser": Globals.laser_amount += 5
		"grenade": Globals.grenade_amount += 1
		"health": Globals.health += 10
	queue_free()
