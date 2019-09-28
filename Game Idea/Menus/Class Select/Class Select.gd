extends Node2D

onready var camera = get_node("Camera")
onready var tween = get_node("Tween")

onready var class_1 = get_node("Class 1")
onready var class_2 = get_node("Class 2")
onready var class_3 = get_node("Class 3")

var classes
var current_index = 1
var classes_size


func _ready():
	
	classes = {
	
		0 : {
			node = class_1
			},
		1 : {
			node = class_2
			},
		2 : {
			node = class_3
			}
	
	}
	
	classes_size = classes.size()
	
	pass


func _process(delta):
	
	if(Input.is_action_just_pressed("Right")):
		
		print("RIGHT")
		
		if(current_index + 1 > classes_size-1):
			current_index = 0
		else:
			current_index += 1
		
		animate_camera_movement(classes[current_index]["node"].position)
		
		pass
	if(Input.is_action_just_pressed("Left")):
		
		print("LEFT")
		
		if(current_index - 1 < 0):
			current_index = classes_size-1
		else:
			current_index -= 1
		
		animate_camera_movement(classes[current_index]["node"].position)
		
		pass
	
	pass


func animate_camera_movement(new_position):
	
	tween.interpolate_property(camera,"position",camera.position,new_position,0.5,Tween.TRANS_CUBIC,Tween.EASE_OUT)
	tween.start()
	
	pass