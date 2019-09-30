extends "res://Scenes/Shop Item/Shop Item.gd"

#Raise sprint speed on player

export(int) var speed_increase = 40

func effect():
	
	Global.player.maximum_sprinting_speed += speed_increase
	
	pass
