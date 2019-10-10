extends TextureButton

onready var timer = get_node("Timer")

func _on_Back_pressed():
	
	var transition = get_node("../Transition")
	transition.animate_fade_out()
	timer.start()
	
	pass


func _on_Timer_timeout():
	
	get_tree().change_scene("res://Menus/Title Screen/Title Screen.tscn")
	
	pass
