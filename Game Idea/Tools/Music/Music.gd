extends AudioStreamPlayer2D

var volume

func _ready():
	
	volume_db += Settings.MUSIC_VOLUME
	volume = volume_db
	
	pass
