extends TextureButton

func _on_Back_to_Menu_pressed():
	
	$Timer.start()
	$"Camera Shake".start()
	
	pass


func _on_Timer_timeout():
	
	get_tree().change_scene("res://Menus/Title Screen/Title Screen.tscn")
	
	pass



