extends AudioStreamPlayer

export(float) var volume = 1

func _ready():
	
	if(Settings.SFX_VOLUME > -60):
		volume_db = Settings.SFX_VOLUME
	
	pass

func _process(delta):
	
	
	volume_db = Settings.SFX_VOLUME
	#volume_db = volume * Settings.SFX_VOLUME
	#volume_db = volume
	#if(Settings.SFX_VOLUME <= 0):
	#	playing = false
	
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

func _on_SFX_tree_entered():
	
	volume_db = Settings.SFX_VOLUME
	
	pass
