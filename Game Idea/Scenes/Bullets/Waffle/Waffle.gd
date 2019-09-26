extends "res://Scenes/Bullet/Bullet.gd"

onready var raycast2d = get_node("RayCast2D")

func _process(delta):
	
	move(delta)
	
	$Sprite.rotation_degrees -= 20
	
	if(raycast2d.is_colliding() == true):
		print("COLLIDE")
	
	pass


func on_body_entered(body):
	
	if(body.is_in_group("Wall")):
		bounce(body)
		pass
	
	if(body.is_in_group("Enemy")):
		targets_hit += 1
		bounce(body)
		if(targets_hit >= piercing):
			queue_free()
	
	pass

func bounce(body):
	
	var collision_point = raycast2d.get_collision_point()
	
	var vector_angle = global_position.angle_to_point(collision_point)
	
	rotation = vector_angle
	speed += 50
	
	pass