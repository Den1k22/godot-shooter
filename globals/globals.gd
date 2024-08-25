extends Node

const MAX_HEALTH = 100

signal stat_change

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
		health = min(value, MAX_HEALTH)
		stat_change.emit()

var player_pos: Vector2
