extends Sprite

func _ready():
	
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	pass

func _process(delta):
	
	position = get_global_mouse_position()
	
	pass