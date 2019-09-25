extends Node2D

onready var tween = get_node("Tween")
onready var sprite = get_node("Origin/Sprite")
onready var charge_position = get_node("Charge Position")

onready var charge_timer = get_node("Charge Timer")
onready var swing_timer = get_node("Swing Timer")

var input_held = true

export(float) var orbit_radius = 10
export(float) var charge_angle = -70
export(float) var base_angle = 45

export(float) var charge_time = 0.75
export(float) var swing_time = 0.15

var charge_percent = 0
var attack_modifier = 5

onready var effect = preload("res://Particles/Meele Swing.tscn")
onready var dust_effect = preload("res://Particles/Dust Particle.tscn")
onready var camera_shake = get_node("Camera Shake")
onready var hitbox = get_node("Origin/Hitbox")
onready var anim_player = get_node("AnimationPlayer")
onready var effect_position = get_node("Origin/Effect Position")
onready var cooldown = get_node("Cooldown Component")

signal swing


func _ready():
	
	charge_timer.connect("timeout",self,"charge_complete")
	swing_timer.connect("timeout",self,"swing_complete")
	
	charge_timer.wait_time = charge_time
	swing_timer.wait_time = swing_time - 0.058
	print(swing_time - 0.055)
	
	pass



func _input(event):
	if(event.is_action_pressed("Attack")):
		input_held = true
		charge()
	elif(event.is_action_released("Attack")):
		input_held = false
		
		if(cooldown.on_cooldown == false):
			
			swing()



func charge():
	
	if(cooldown.on_cooldown == false):
		charge_percent = 0.4
		charge_timer.start()
		
		tween.stop_all()
		tween.interpolate_property(sprite,"position",sprite.position,charge_position.position,charge_time-0.1,Tween.TRANS_BACK,Tween.EASE_OUT)
		tween.interpolate_property(sprite,"scale",sprite.scale,Vector2(1.1,1.1),charge_time-0.2,Tween.TRANS_LINEAR,Tween.EASE_OUT)
		tween.interpolate_property(sprite,"rotation_degrees",sprite.rotation_degrees,charge_angle,charge_time-0.1,Tween.TRANS_BACK,Tween.EASE_OUT)
		tween.start()
	
	
	
	pass

func swing():
	
	swing_timer.start()
	anim_player.play("Base")
	
	hitbox.damage = 20 * charge_percent + (attack_modifier * Global.player.damage_bonus)
	camera_shake.shake_power = 5 * charge_percent
	
	tween.stop_all()
	tween.interpolate_property(sprite,"position",sprite.position,Vector2(orbit_radius,0),0.15,Tween.TRANS_BACK,Tween.EASE_OUT)
	tween.interpolate_property(sprite,"scale",sprite.scale,Vector2(1,1),0.15,Tween.TRANS_BACK,Tween.EASE_OUT)
	tween.interpolate_property(sprite,"rotation_degrees",sprite.rotation_degrees,base_angle,0.15,Tween.TRANS_BACK,Tween.EASE_OUT)
	tween.start()
	cooldown.start()
	
	pass


func scale_up():
	
	tween.interpolate_property(sprite,"scale",Vector2(1.6,1.6),sprite.scale,0.2,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	
	pass




func charge_complete():
	
	charge_percent = 1
	
	pass



func swing_complete():
	
	emit_signal("swing", 0.1)
	emit_signal("swing")
	scale_up()
	
	
	var effect_instance = effect.instance()
	effect_instance.position = effect_position.global_position
	effect_instance.rotation_degrees = $"Origin".rotation_degrees
	
	var dust_instance = dust_effect.instance()
	dust_instance.position = effect_position.global_position
	dust_instance.rotation_degrees = $"Origin".rotation_degrees
	
	Global.world.add_child_below_node(Global.ground_tilemap,effect_instance)
	Global.world.add_child(dust_instance)
	
	pass



func _on_Cooldown_Component_cooldown_finished():
	
	if(input_held == true):
		print("YOOP")
		charge()
	
	pass
