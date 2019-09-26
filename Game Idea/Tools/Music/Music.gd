extends AudioStreamPlayer2D

export(float) var volume = 1

func _ready():
	
	volume_db = volume
	
	
	pass


func _process(delta):
	
	volume_db = volume * Settings.MUSIC_VOLUME
	
	if(Settings.MUSIC_VOLUME <= 0):
		playing = false
	
	pass