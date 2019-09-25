extends Node2D

export(NodePath) var node_path
onready var node

export(float) var up_angle = 0
export(float) var down_angle = 0

export(float) var swing_time = 0.4

var is_up = true
onready var tween = get_node("Tween")


func _ready():
	
	#Get node to swing
	node = get_node(node_path)
	
	#Set up starting state
	is_up = true
	node.rotation_degrees = up_angle
	
	pass



func swing():
	
	if(is_up == true):
		animate_alternate_swing()
		#animate_swing(down_angle)
		is_up = false
	else:
		animate_alternate_swing()
		#animate_swing(up_angle)
		is_up = true
	
	pass


func animate_swing(end_angle):
	
	tween.interpolate_property(node,"rotation_degrees",node.rotation_degrees,end_angle,swing_time,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
	tween.start()
	
	pass

func animate_alternate_swing():
	
	tween.interpolate_property(node,"scale",node.scale,Vector2(node.scale.x * -1,node.scale.y),swing_time,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
	tween.start()
	
	pass
