extends AudioStreamPlayer2D

var volume

func _ready():
	
	volume_db += Settings.MUSIC_VOLUME
	volume = volume_db
	
	pass


func _process(delta):
	
	if(get_tree().paused == true):
		volume_db = volume - 5
	else:
		volume_db = volume + 5
	
	pass