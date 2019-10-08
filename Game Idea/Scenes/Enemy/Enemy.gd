extends KinematicBody2D

onready var target = position

var velocity = Vector2(1,1)
var speed_range = 50
export(float) var speed = 20
export(float) var MAX_FORCE = 0.06

onready var health = get_node("Health Component")
onready var anim_player = get_node("AnimationPlayer")
onready var tween = get_node("Tween")

onready var shader = preload("res://WhiteShader.tres")

const death_sfx = preload("res://Tools/Temporary Sound FX/Temp Sound FX.tscn")

func _ready():
	
	speed = speed + rand_range(0, speed_range)
	
	pass


func _physics_process(delta):
	
		
	target = Global.player.position
	velocity = steer(target)
	move_and_slide(velocity)
	
	
	#NIGHTMARE MODE
	if(Settings.nightmare == true):
		#speed = speed + (health.maximum_value - health.value) / 3
		speed = (Global.player.maximum_speed + Global.player.speed_bonus) + 100
	
	
	pass



func steer(target : Vector2) -> Vector2:
	var helper= (target - get_position()).normalized() * speed
	var desired_velocity = Vector2(helper.x, helper.y)
	var steer = desired_velocity - velocity
	var target_velocity = velocity + (steer * MAX_FORCE )
	return target_velocity


func animate_hit():
	
	tween.interpolate_property($Sprite,"scale",Vector2(1.45,1.45),Vector2(1,1),0.7,Tween.TRANS_BACK,Tween.EASE_OUT)
	tween.start()
	
	pass


func _on_Enemy_tree_exiting():
	
	if(Settings.SFX_VOLUME > -60):
		var sfx_instance = death_sfx.instance()
		Global.world.add_child(sfx_instance)
	
	Global.enemies_defeated += 1
	Engine.time_scale = 1
	print("Enemies Defeated: " + str(Global.enemies_defeated))
	
	pass


func flash_white():
	
	$Sprite.material = shader
	
	var t = Timer.new()
	t.set_wait_time(0.1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	
	$Sprite.material = null
	
	t.queue_free()
	
	pass


func _on_Hurtbox_damaged(damage):
	
	animate_hit()
	flash_white()
	
	Engine.time_scale = 0.6
	var t = Timer.new()
	t.set_wait_time(0.06)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	Engine.time_scale = 1
	
	
	t.queue_free()
	
	pass
