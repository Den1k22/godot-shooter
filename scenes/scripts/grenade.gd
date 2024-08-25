extends RigidBody2D

var speed = 1000

func explode():
	$AnimationPlayer.play("Explosion")

func _on_explosion_area_body_entered(body):
	if "hit" in body:
		body.hit()
