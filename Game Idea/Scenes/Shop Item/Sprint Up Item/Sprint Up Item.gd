extends "res://Scenes/Shop Item/Shop Item.gd"

#Raise sprint speed on player

export(int) var speed_increase = 40

func _ready():
	
	._ready()
	text_notification = "+Sprint"
	
	pass

func effect():
	
	Global.player.maximum_sprinting_speed += speed_increase
	
	pass
