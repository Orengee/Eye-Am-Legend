extends Node2D

onready var tween = get_node("Tween")
onready var sprite = get_node("Origin/Sprite")
export(float) var kickback_amount = -25

func animate_kickback():
	
	tween.interpolate_property(self,"rotation_degrees",kickback_amount,0,0.2,Tween.TRANS_BACK,Tween.EASE_OUT)
	tween.start()
	
	pass
