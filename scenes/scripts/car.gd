extends PathFollow2D

var player_nearby: bool = false

@onready var line1: Line2D = $Turret/RayCast2D/Line2D
@onready var line2: Line2D = $Turret/RayCast2D2/Line2D


func fire():
	Globals.health -= 20


func _process(delta: float) -> void:
	progress_ratio += 0.01 * delta
	if player_nearby:
		$Turret.look_at(Globals.player_pos)
	#print($Turret/RayCast2D.get_collider())


func _on_notice_area_body_entered(_body: Node2D) -> void:
	player_nearby = true
	$AnimationPlayer.play("laser_load")


func _on_notice_area_body_exited(_body: Node2D) -> void:
	player_nearby = false
	$AnimationPlayer.stop()
