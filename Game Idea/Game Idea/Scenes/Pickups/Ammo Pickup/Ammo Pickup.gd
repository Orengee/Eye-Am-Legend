extends Area2D



func _on_Ammo_Pickup_body_entered(body):
	
	if(body.is_in_group("Player")):
		
		body.ammo_pickup()
		queue_free()
		
		pass
	
	pass
