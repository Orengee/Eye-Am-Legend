extends "res://Scenes/Skills/Skill.gd"

onready var airstrike = preload("res://Scenes/Airstrike/Airstrike.tscn")

func skill():
	
	print("AIRSTRIKE")
	
	var airstrike_instance = airstrike.instance()
	airstrike_instance.global_position = get_global_mouse_position()
	
	Global.world.add_child(airstrike_instance)
	
	pass