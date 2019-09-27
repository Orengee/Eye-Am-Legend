extends AnimatedSprite

func _ready():
	
	playing = true
	
	pass

func _on_Shooting_Effect_animation_finished():
	
	queue_free()
	
	pass
