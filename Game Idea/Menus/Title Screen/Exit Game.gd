extends TextureButton


func _on_Settings_pressed():
	
	var transition = get_node("../../Transition")
	$"Camera Shake".start()
	$"Button Sound".play()
	
	get_tree().quit()
	
	pass


