extends ItemContainer

func hit():
	play_sound_on_hit()
	if not opened:
		$LidSprite.hide()
		
		var pos = $SpawnPosition/Marker2D.global_position # $SpawnPosition.get_child(0).global_position
		open.emit(pos, current_diretion)
			
		opened = true
