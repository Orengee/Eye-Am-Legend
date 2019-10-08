extends CheckBox


func _ready():
	
	pressed = OS.window_fullscreen
	
	pass
	
	
func _process(delta):
	
	Settings.FULLSCREEN = pressed
	OS.window_fullscreen = Settings.FULLSCREEN
	
	pass
