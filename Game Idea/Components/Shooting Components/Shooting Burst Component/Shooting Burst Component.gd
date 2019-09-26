extends "res://Components/Shooting Components/Shooting Component.gd"

export(int) var number_of_bullets = 3

func shoot():
	
	for bullet in number_of_bullets:
		var projectile_instance = projectile.instance()
		projectile_instance.position = projectile_spawn_node.global_position
		
		if(aiming_node != null):
			projectile_instance.rotation = (aiming_node.aim_angle + deg2rad(90)) + deg2rad(rand_range(-spread,spread))
		
		projectile_instance.speed = projectile_speed
		projectile_instance.damage = damage + (attack_modifier * Global.player.damage_bonus)
		Global.world.add_child(projectile_instance)
		
	emit_signal("shoot")
	
	pass

func attack():
	
	.attack()
	
	pass

