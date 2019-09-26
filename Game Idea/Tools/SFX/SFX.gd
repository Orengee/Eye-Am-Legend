extends AudioStreamPlayer2D

export(float) var volume = 1

func _ready():
	
	volume_db = volume
	
	pass

func _process(delta):
	
	volume_db = volume * Settings.SFX_VOLUME
	if(Settings.SFX_VOLUME <= 0):
		playing = false
	
	pass

func _play():
	
	play(0.0)
	
	pass
	

func _play_range(strength):
	
	play(0.0)
	
	pass

func stop():
	
	playing = false
	
	pass