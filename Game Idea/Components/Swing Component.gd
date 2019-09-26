extends Node2D

export(float) var recovery_time
export(NodePath) var target_object

var object

onready var tween = get_node("Tween")


func _ready():
	
	object = get_node(target_object)
	
	pass


func swing():
	
	if(tween.is_active() == false):
		object.scale.y *= -1.3
		
		tween.interpolate_property(object,"scale", object.scale,Vector2(object.scale.x,1 * -1),recovery_time,Tween.TRANS_LINEAR,Tween.EASE_OUT)
		tween.start()
	
	pass
