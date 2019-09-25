extends "res://Scenes/Bullet/Bullet.gd"


func _process(delta):
	
	var target = get_global_mouse_position()
	var angle_to_target = self.global_position.angle_to_point(target)
	
	rotation = angle_to_target + deg2rad(-90)
	
	move(delta)
	
	pass