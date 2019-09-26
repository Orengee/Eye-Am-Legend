extends Node2D

onready var tween = get_node("Tween")
onready var sprite = get_node("Rotation Pivot/Sprite")
onready var rotate = get_node("Rotate Toward Mouse")

var oribiting_radius = 15
var base_rotation = 90
var charge_angle = -60
var charge_time = 1

var swing_angle = 40

func _input(event):
	
	if(event.is_action_pressed("Attack")):
		charge()
		pass
	elif(event.is_action_released("Attack")):
		swing()
		pass


func _process(delta):
	if(Input.is_action_just_pressed("Attack")):
		charge()


func charge():
	
	tween.stop_all()
	tween.interpolate_property(sprite,"position",sprite.position,$"Charge Position".position,charge_time-0.1,Tween.TRANS_SINE,Tween.EASE_OUT)
	tween.interpolate_property(sprite,"rotation_degrees",base_rotation,charge_angle,charge_time-0.1,Tween.TRANS_SINE,Tween.EASE_OUT)
	tween.interpolate_property(sprite,"scale",Vector2(1,1),Vector2(1.3,1.3),charge_time-0.1,Tween.TRANS_SINE,Tween.EASE_OUT)
	tween.start()
	

func swing():
	
	tween.stop_all()
	tween.interpolate_property(sprite,"position",sprite.position,Vector2(oribiting_radius,0),0.05,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	tween.interpolate_property(sprite,"rotation_degrees",sprite.rotation_degrees,base_rotation,0.05,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	tween.interpolate_property(sprite,"scale",Vector2(1.3,1.3),Vector2(1,1),0.15,Tween.TRANS_BOUNCE,Tween.EASE_OUT)
	tween.start()
	
	pass
