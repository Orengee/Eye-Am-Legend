extends Node2D

export(String) var action

signal triggered

func _process(delta):
	
	if(Input.is_action_pressed(action)):
		emit_signal("triggered")
	
	pass