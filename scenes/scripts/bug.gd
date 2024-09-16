extends CharacterBody2D

var player_nearby: bool = false
var can_attack: bool = false
var can_attack_cooldown: bool = false
#var is_moving: bool = false
var health: int = 50
var speed: int = 300

signal bite()

func _process(_delta):
	if player_nearby:
		look_at(Globals.player_pos)

		# var direction = (Globals.player_pos - position).normalized()
		var direction = position.direction_to(Globals.player_pos)
		velocity = direction * speed
	else:
		velocity = Vector2()
		
	move_and_slide()

func hit():
	health -= 10
	$Particles/HitParticles.emitting = true
	$AudioStreamPlayer2D.play()
	$AnimatedSprite2D.material.set_shader_parameter("progress", 1)
	await get_tree().create_timer(0.2).timeout
	if health <= 0:
		queue_free()
	else:
		$AnimatedSprite2D.material.set_shader_parameter("progress", 0)

func _on_notice_area_body_entered(_body):
	player_nearby = true
	$AnimatedSprite2D.play("moving")

func _on_notice_area_body_exited(_body):
	player_nearby = false
	$AnimatedSprite2D.stop()

func _on_attack_area_body_entered(_body):
	can_attack = true
	$AnimatedSprite2D.play("attack")

func _on_attack_area_body_exited(_body):
	can_attack = false
	$AnimatedSprite2D.play("moving")

func _on_bite_cooldown_timeout():
	$AnimatedSprite2D.play("attack")

func _on_animated_sprite_2d_animation_finished():
	if can_attack:
		bite.emit()
		$BiteCooldown.start()
