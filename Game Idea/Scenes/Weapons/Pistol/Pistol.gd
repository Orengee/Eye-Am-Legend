extends Node2D

onready var tween = get_node("Tween")
onready var sprite = get_node("Origin/Sprite")
onready var rotate_to_mouse = get_node("Origin/Rotate Toward Mouse")

var clip_component = null

export(float) var kickback_amount = -25
export(float) var kickback_length = 0.25

func _ready():
	
	if(self.has_node("Clip Component") == true):
		clip_component = self.get_node("Clip Component")
	
	pass

func animate_kickback():
	
	var kickback
	
	var angle = rad2deg(rotate_to_mouse.angle)
	
	if(angle < -90 or angle > 90):
		kickback = -kickback_amount
	else:
		kickback = kickback_amount
	
	
	tween.interpolate_property(self,"rotation_degrees",kickback,0,kickback_length,Tween.TRANS_BACK,Tween.EASE_OUT)
	tween.start()
	
	pass
