extends CharacterBody2D

var player_nearby: bool = false
var can_laser: bool = true
@onready var laser_marker0 = $LaserSpawnPositions/Marker2D
@onready var laser_marker1 = $LaserSpawnPositions/Marker2D2
var first_laser = true

var health: int = 30

signal laser(pos, direction)

func _process(_delta):
	if player_nearby:
		look_at(Globals.player_pos)
		if can_laser:
			var selected_laser = laser_marker0 if first_laser else laser_marker1
			first_laser = !first_laser
			
			var pos: Vector2 = selected_laser.global_position
			var direction: Vector2 = (Globals.player_pos - position).normalized()
			laser.emit(pos, direction)
			can_laser = false
			$LaserCooldown.start()

func _on_attack_area_body_entered(_body):
	player_nearby = true

func _on_attack_area_body_exited(_body):
	player_nearby = false

func _on_laser_cooldown_timeout():
	can_laser = true
	
func hit():
	health -= 10
	if health <= 0:
		queue_free()
	else:
		$Sprite2D.material.set_shader_parameter("progress", 1)
		await get_tree().create_timer(0.2).timeout
		$Sprite2D.material.set_shader_parameter("progress", 0)
