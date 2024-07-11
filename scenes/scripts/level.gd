extends Node2D
class_name LevelParent 

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/Projectiles/grenade.tscn")

func _on_player_laser(pos, direction):
	var laser = laser_scene.instantiate() as Area2D
	laser.position = pos	
	laser.direction = direction
	laser.rotation = direction.angle()
	$Projectiles.add_child(laser)
	$UI.update_laser_text()

func _on_player_grenade(pos, direction):
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed

	$Projectiles.add_child(grenade)
	$UI.update_grenade_text()


func _on_house_player_entered():
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property($Player/Camera2D, "zoom", Vector2(1.5, 1.5), 1).set_trans(Tween.TRANS_QUAD)
	tween.tween_property($Player,"modulate:a", 0.1, 2).from(0.75)


func _on_house_player_exited():
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property($Player/Camera2D, "zoom", Vector2(1, 1), 1)
	tween.tween_property($Player,"modulate:a", 1, 0.5).from(0.25)


func _on_player_update_stats():
	$UI.update_laser_text()
	$UI.update_grenade_text()
