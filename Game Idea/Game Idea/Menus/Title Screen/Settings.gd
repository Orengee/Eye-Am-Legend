extends TextureButton


func _on_Settings_pressed():
	
	$"Camera Shake".start()
	$"Button Sound".play()
	$Timer.start()
	pass


func _on_Timer_timeout():
	get_tree().change_scene("res://Menus/Settings/Settings.tscn")
	pass # Replace with function body.
