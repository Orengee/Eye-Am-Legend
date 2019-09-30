extends AnimatedSprite

func _ready():
	
	self.playing = true
	
	pass

func _on_Hit_Effect_animation_finished():
	
	queue_free()
	
	pass
