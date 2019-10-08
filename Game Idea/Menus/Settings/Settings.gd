extends Node2D

onready var sfx_tester = get_node("SFX Test")

var sfx_selected = false

func _ready():
	
	
	$Transition.cutoff = 1.0
	$Transition.animate_fade_in()
	
	pass


func _input(event):
	
	if(event.is_action_released("Confirm") and sfx_selected):
		sfx_tester._play()
		
	

func _on_Music_Settings_value_changed(value):
	
	Settings.MUSIC_VOLUME = linear2db(value)
	print(Settings.MUSIC_VOLUME)
	pass


func _on_Sound_FX_Settings_value_changed(value):
	
	
	Settings.SFX_VOLUME = linear2db(value)
	print(Settings.SFX_VOLUME)	
	
	pass



func _on_Sound_FX_Settings_mouse_entered():
	
	sfx_selected = true
	
	pass


func _on_Sound_FX_Settings_mouse_exited():
	
	sfx_selected = false
	
	pass
