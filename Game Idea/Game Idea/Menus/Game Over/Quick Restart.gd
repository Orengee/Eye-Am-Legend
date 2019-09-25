extends TextureButton



func _on_Quick_Restart_pressed():
	
	$Timer.start()
	$"Camera Shake".start()
	
	pass


func _on_Timer_timeout():
	
	Global.enemies_defeated = 0
	
	get_tree().change_scene("res://World.tscn")
	
	pass
