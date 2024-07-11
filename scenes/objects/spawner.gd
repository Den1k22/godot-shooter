extends StaticBody2D

var item_scene: PackedScene = preload("res://scenes/objects/item.tscn")

func hit_spawner():
	var item = item_scene.instantiate() as Area2D	
	$".".add_child(item)
