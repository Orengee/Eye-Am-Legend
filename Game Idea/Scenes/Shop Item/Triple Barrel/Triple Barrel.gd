extends "res://Scenes/Shop Item/Shop Item.gd"

export(float) var fire_rate_percent = 0.66
export(float) var spread_percent = 4

func effect():
	
	Global.fire_rate_multiplier *= fire_rate_percent
	Global.spread_multiplier *= spread_percent
	
	var held_weapon = Global.player.weapon_node.get_child(0)
	
	if(held_weapon.has_node("Cooldown Component") == true):
		var cooldown_component = held_weapon.get_node("Cooldown Component")
		cooldown_component.duration *= fire_rate_percent
		cooldown_component.timer.wait_time *= fire_rate_percent
	else:
		print("NO COOLDOWN NODE")
	
	if(held_weapon.has_node("Shooting Component") == true):
		var shooting_component = held_weapon.get_node("Shooting Component")
		shooting_component.spread *= spread_percent
	elif(held_weapon.has_node("Shooting Burst Component")):
		var shooting_component = held_weapon.get_node("Shooting Burst Component")
		shooting_component.spread *= spread_percent
	
	pass
