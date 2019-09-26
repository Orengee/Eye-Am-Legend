extends TextureButton

onready var world = preload("res://World.tscn")

func _on_TextureButton_pressed():
	
	
	$"Camera Shake".start()
	$"Button Sound".play()
	$Timer.start()
	
	
	pass


func _on_Timer_timeout():
	get_tree().change_scene("res://Menus/Difficulty Select/Difficulty Select.tscn")
	pass
