extends ItemContainer

func hit():
	var pos = $SpawnPosition/Marker2D.global_position
	for i in range(10):
		open.emit(pos, current_diretion)
