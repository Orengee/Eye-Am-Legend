extends "res://Scenes/Enemy/Enemy.gd"


func _ready():
	
	Global.enemies.append(self)
	
	MAX_FORCE = 0.04
	MAX_SEPARTION_FORCE = 0
	
	speed = speed + rand_range(0, speed_range)
	
	min_speed = speed - 10
	
	pass


func _physics_process(delta):
	
	target = Global.player.position
	
	velocity += steer(target) * delta
	move_and_slide(velocity)


func _on_Flyer_tree_exiting():
	
	Global.enemies.erase(self)
	
	if(Settings.SFX_VOLUME > -60):
		var sfx_instance = death_sfx.instance()
		Global.world.add_child(sfx_instance)
	
	Global.enemies_defeated += 1
	Engine.time_scale = 1
	print("Enemies Defeated: " + str(Global.enemies_defeated))
	
	pass
