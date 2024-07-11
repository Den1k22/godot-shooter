extends Area2D

@export var speed: int = 400
var direction: Vector2 = Vector2.UP

func _ready():
	$Lifespan.start()

func _process(delta):
	pass
	position += direction * speed * delta
# Called when the node enters the scene tree for the first time.


func _on_body_entered(body):
	if "hit" in body:
		body.hit()
		print(body)
		body.queue_free()
	if "hit_spawner" in body:
		body.hit_spawner()
	
	queue_free()

func _on_lifespan_timeout():
	queue_free()
