extends CharacterBody2D

signal laser(pos, direction)
signal grenade(pos, direction)

#var playersRotaion = 0
var can_laser: bool = true
var can_grenade: bool = true
#var laser_markers = null

@export var max_speed: int = 500
var speed: int = max_speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	
	#if (not direction == Vector2.ZERO):
		#playersRotaion = direction.angle()
	#
	#rotation = playersRotaion

	move_and_slide()
	Globals.player_pos = global_position
	#position += direction * 400 * delta
	
	look_at(get_global_mouse_position())
	
	var player_look_direction = (get_global_mouse_position() - position).normalized()
	
	if (Input.is_action_pressed("primary action") and can_laser and Globals.laser_amount > 0):
		Globals.laser_amount -= 1
		$LaserTimer.start()
		can_laser = false
		
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		laser.emit(selected_laser.global_position, player_look_direction)
		$LaserParticles.emitting = true

	if (Input.is_action_pressed("seconday action") and can_grenade and Globals.grenade_amount > 0):
		Globals.grenade_amount -= 1
		$GrenadeTimer.start()
		can_grenade = false
		
		grenade.emit($GrenadeStartPosition.global_position, player_look_direction)

func _on_laser_timer_timeout():
	can_laser = true

func _on_grenade_timer_timeout():
	can_grenade = true

func hit():
	Globals.health -= 10
