extends "res://Scenes/Shop Item/Shop Item.gd"

export(int) var bonus = 20

func effect():
	
	Global.player.speed_bonus += bonus
	price = floor(price * 2)
	
	pass

func _play():
	pass # Replace with function body.
