extends RigidBody2D

@export var speed: int = 1000
var direction: Vector2 = Vector2.UP

# Called when the node enters the scene tree for the first time.
func _ready():
	#apply_impulse(direction.rotated(rotation) * speed)
	#position += direction.rotated(rotation) * speed * delta
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func explode():
	$AnimationPlayer.play("Explosion")
