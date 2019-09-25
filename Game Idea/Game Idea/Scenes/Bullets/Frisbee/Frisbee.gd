extends "res://Scenes/Bullet/Bullet.gd"


func _process(delta):
	
	rotation_degrees += 5
	move(delta)
	
	pass