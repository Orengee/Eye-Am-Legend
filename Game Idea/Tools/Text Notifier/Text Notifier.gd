extends Label

var speed = 20

func _process(delta):
	
	rect_position.y -= speed * delta
	
	pass

func _on_AnimationPlayer_animation_finished(anim_name):
	
	self.queue_free()
	
	pass
