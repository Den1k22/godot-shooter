extends CharacterBody2D

var active: bool = false
var health: int = 20

var speed = 0
var MAX_SPEED = 600
var speed_multiplier = 1

func _ready() -> void:
	$Explosion.hide()
	$Drone.show()
	$ExplosionArea/CollisionShape2D.disabled = true
	
func _process(delta: float) -> void:
	if active:
		var direction = position.direction_to(Globals.player_pos)
		velocity = direction * speed * speed_multiplier
		if speed_multiplier > 0:
			look_at(Globals.player_pos)
		var collision = move_and_collide(velocity * delta)
		if collision:
			$AnimationPlayer.play("explosion")

func hit():
	health -= 10
	$Particles/HitParticles.emitting = true
	$Drone.material.set_shader_parameter("progress", 1)
	await get_tree().create_timer(0.2).timeout
	if health <= 0:
		$AnimationPlayer.play("explosion")
	else:
		$Drone.material.set_shader_parameter("progress", 0)
		
func stop_movement():
	speed_multiplier = 0


func _on_notice_area_body_entered(_body: Node2D) -> void:
	active = true
	var tween = create_tween()
	tween.tween_property(self, "speed", MAX_SPEED, 4)

func _on_explosion_area_body_entered(body: Node2D) -> void:
	if "hit" in body:
		body.hit()
