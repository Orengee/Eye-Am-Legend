extends "res://Scenes/Weapons/Pistol/Pistol.gd"

signal shot

func on_shoot():
	
	emit_signal("shot", 0.1)
	
	pass