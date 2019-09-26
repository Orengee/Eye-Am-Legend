extends Node2D

#Rotate the parent of this object to face toward the mouse
onready var parent = get_parent()
export(NodePath) var reference_path

onready var reference_object = get_node(reference_path)
var aim_angle




func _process(delta):
	
	var mouse_position = get_global_mouse_position()
	aim_angle = mouse_position.angle_to_point(reference_object.global_position)
	
	pass
