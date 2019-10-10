extends TextureButton


func _on_TextureButton_pressed():
	
	var transition = get_node("../../../Transition")
	transition.animate_fade_out()
	$"Camera Shake".start()
	$"Button Sound".play()
	$Timer.start()
	
	
	pass


func _on_Timer_timeout():
	get_tree().change_scene("res://Menus/Difficulty Select/Difficulty Select.tscn")
	pass
