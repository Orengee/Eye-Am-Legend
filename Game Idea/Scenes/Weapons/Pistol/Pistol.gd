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
		
	if(self.has_node("Reload Component") == true):
		var reload_component = self.get_node("Reload Component")
		reload_component.reload_time *= Global.reload_multiplier
		reload_component.timer.wait_time *= Global.reload_multiplier
		print(reload_component.reload_time)
	
	if(self.has_node("Cooldown Component") == true):
		var cooldown_component = self.get_node("Cooldown Component")
		cooldown_component.duration *= Global.fire_rate_multiplier
		cooldown_component.timer.wait_time *= Global.fire_rate_multiplier
		print(cooldown_component.duration)
	
	if(self.has_node("Shooting Component") == true):
		var shooting_component = self.get_node("Shooting Component")
		shooting_component.spread *= Global.spread_multiplier
		print("SPREAD: " + str(shooting_component.spread))
	
	
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
