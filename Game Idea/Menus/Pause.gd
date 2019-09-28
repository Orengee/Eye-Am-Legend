extends Label



func pause():
	
	get_tree().paused = true
	visible = true
	
	pass


func unpause():
	
	get_tree().paused = false
	visible = false
	
	pass


func _process(delta):
	
	if(Input.is_action_just_pressed("Pause")):
		
		if(get_tree().paused == true):
			unpause()
		else:
			pause()
		
		pass
	
	pass