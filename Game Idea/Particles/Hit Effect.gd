extends AnimatedSprite

var scale_random = 0.4
var position_random_x = 5
var position_random_y = 5

func _ready():
	
	self.playing = true
	var rand_x = rand_range(-position_random_x,position_random_x)
	var rand_y = rand_range(-position_random_y,position_random_y)
	var rand_scale = rand_range(0,scale_random)
	
	global_position += Vector2(rand_x,rand_y)
	scale += Vector2(rand_scale,rand_scale)
	
	pass

func _on_Hit_Effect_animation_finished():
	
	queue_free()
	
	pass
