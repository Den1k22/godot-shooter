extends Node

const MAX_HEALTH = 100

signal stat_change

var player_hit_sound: AudioStreamPlayer2D

var laser_amount = 20:
	set(value):
		laser_amount = value
		stat_change.emit()
var grenade_amount = 10:
	set(value):
		grenade_amount = value
		stat_change.emit()

var health = 60:
	set(value):
		if (value < health):
			player_hit_sound.play()

		health = min(value, MAX_HEALTH)
		stat_change.emit()

var player_pos: Vector2

func _ready() -> void:
	player_hit_sound = AudioStreamPlayer2D.new()
	player_hit_sound.stream = load("res://audio/solid_impact.ogg")
	add_child(player_hit_sound)
