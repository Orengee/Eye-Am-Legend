extends "res://Scenes/Shop Item/Shop Item.gd"

export(float) var reload_percent = 0.5

func _ready():
	
	._ready()
	text_notification = "+Reload Speed"
	
	pass

func effect():
	
	Global.reload_multiplier *= reload_percent
	
	var held_weapon = Global.player.weapon_node.get_child(0)
	if(held_weapon.has_node("Reload Component") == true):
		var reload_component = held_weapon.get_node("Reload Component")
		reload_component.reload_time *= reload_percent
		reload_component.timer.wait_time *= reload_percent
	else:
		print("NO RELOAD COMPONENT")
		
	pass