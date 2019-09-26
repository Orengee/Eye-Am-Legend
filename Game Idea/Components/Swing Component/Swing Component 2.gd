extends Node2D

export(NodePath) var node_path
onready var node

export(float) var swing_time = 0.4

var is_up = true
onready var tween = get_node("Tween")


#Instantly flips backward then animates it swinging back to original orientation


func _ready():
	
	#Get node to swing
	node = get_node(node_path)
	
	pass



func swing():
	
	animate_swing()
	
	pass

func animate_swing():
	
	tween.interpolate_property(node,"scale",node.scale,Vector2(node.scale.x * -1,node.scale.y),swing_time,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
	tween.start()
	
	pass