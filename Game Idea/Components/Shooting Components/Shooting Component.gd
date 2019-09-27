extends Node2D

export(PackedScene) var projectile
export(PackedScene) var shooting_effect
export(NodePath) var projectile_spawn_path
export(float) var spread = 0
export(int) var damage = 1
export(float) var projectile_speed
export(int) var attack_modifier = 0

var disabled = false

var aiming_node
var clip_node
var cooldown_node

var projectile_spawn_node

signal shoot

func _ready():
	
	projectile_spawn_node = get_node(projectile_spawn_path)
	
	var parent_nodes = get_parent().get_children()
	
	for node in parent_nodes:
		if(node.is_in_group("CAiming")):
			aiming_node = node
		if(node.is_in_group("CClip")):
			clip_node = node
		if(node.is_in_group("CCooldown")):
			cooldown_node = node
	
	pass



func attack():
	
	if(disabled == false):
		if(cooldown_node != null):
			if(cooldown_node.on_cooldown == false):
				shoot()
				cooldown_node.start()
		else:
			shoot()
			
	
	pass



func shoot():
	
	#Create shooting effect
	if(shooting_effect != null):
		print("ALKSFJKLAS")
		var shooting_effect_instance = shooting_effect.instance()
		shooting_effect_instance.global_position = projectile_spawn_node.global_position
		Global.world.add_child(shooting_effect_instance)
	
	#Create and set up projectile
	var projectile_instance = projectile.instance()
	projectile_instance.position = projectile_spawn_node.global_position
	
	if(aiming_node != null):
		projectile_instance.rotation = (aiming_node.aim_angle + deg2rad(90)) + deg2rad(rand_range(-spread,spread))
	
	projectile_instance.speed = projectile_speed
	projectile_instance.damage = damage + (attack_modifier * Global.player.damage_bonus)
	projectile_instance.z_index = -1
	
	if(cooldown_node != null):
		cooldown_node.start()
	
	Global.world.add_child(projectile_instance)
	emit_signal("shoot")
	
	pass



func disable():
	
	disabled = true
	
	pass



func enable():
	
	disabled = false
	
	pass
