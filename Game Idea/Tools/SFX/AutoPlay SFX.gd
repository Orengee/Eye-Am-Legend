extends "res://Tools/SFX/SFX.gd"

func _ready():
	
	
	if(Settings.SFX_VOLUME > -60):
		playing = true
		volume_db = Settings.SFX_VOLUME
		
	pass
