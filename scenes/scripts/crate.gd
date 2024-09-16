extends ItemContainer

func hit():
	play_sound_on_hit()
	if not opened:
		$LidSprite.hide()
		for i in range(5):
			var pos = $SpawnPosition.get_child(randi() % $SpawnPosition.get_child_count()).global_position
			open.emit(pos, current_diretion)
			
		opened = true
