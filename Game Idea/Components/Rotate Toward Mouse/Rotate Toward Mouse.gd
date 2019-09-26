extends Node2D

#Rotate the parent of this object to face toward the mouse
onready var parent = get_parent()

export(bool) var enable_flip
export(NodePath) var flip_node_path
export(float) var smoothing = 0.4

onready var flip_node

var angle


func _ready():
	
	if(enable_flip == true):
		flip_node = get_node(flip_node_path)
	
	pass


func _process(delta):
	
	var mouse_position = get_global_mouse_position()
	angle = mouse_position.angle_to_point(global_position)
	
	if(parent.rotation < angle - deg2rad(180)):
		parent.rotation += deg2rad(360)
	elif(parent.rotation > angle + deg2rad(180)):
		parent.rotation -= deg2rad(360)
	
	if(angle > deg2rad(90) or angle < deg2rad(-90)):
		flip_node.scale.y = -1
	else:
		flip_node.scale.y = 1
	
	parent.rotation = lerp(parent.rotation,angle,smoothing)
	
	pass