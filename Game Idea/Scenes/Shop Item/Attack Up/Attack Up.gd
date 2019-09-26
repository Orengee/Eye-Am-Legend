extends "res://Scenes/Shop Item/Shop Item.gd"

export(int) var bonus = 2

func effect():
	
	Global.player.damage_bonus += bonus
	price = floor(price * 2)
	
	pass