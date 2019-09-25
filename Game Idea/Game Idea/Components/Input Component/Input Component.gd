extends Node2D

export(String) var action

signal triggered

func _input(event):
	
	if(event.is_action_pressed(action)):
		emit_signal("triggered")
	
	pass
