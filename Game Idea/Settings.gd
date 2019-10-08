extends Node

var MUSIC_VOLUME = 0
var SFX_VOLUME = 0
var FULLSCREEN = false

var nightmare = true

func _input(event):
	
	if(event.is_action_pressed("Fullscreen")):
		if(FULLSCREEN):
			FULLSCREEN = false
		else:
			FULLSCREEN = true
		OS.window_fullscreen = FULLSCREEN