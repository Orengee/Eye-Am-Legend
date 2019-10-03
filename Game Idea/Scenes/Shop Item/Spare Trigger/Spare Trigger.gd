extends "res://Scenes/Shop Item/Shop Item.gd"

export(float) var fire_rate_percent = 0.85

func effect():
	
	Global.fire_rate_multiplier *= fire_rate_percent
	
	var held_weapon = Global.player.weapon_node.get_child(0)
	if(held_weapon.has_node("Cooldown Component") == true):
		var cooldown_component = held_weapon.get_node("Cooldown Component")
		cooldown_component.duration *= fire_rate_percent
		cooldown_component.timer.wait_time *= fire_rate_percent
	else:
		print("NO COOLDOWN NODE")
		
	pass