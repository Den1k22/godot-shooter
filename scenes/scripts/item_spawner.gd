extends ItemContainer

func hit():
	var pos = $SpawnPosition/Marker2D.global_position
	for i in range(100):
		open.emit(pos, current_diretion)
