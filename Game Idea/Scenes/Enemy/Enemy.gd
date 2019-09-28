extends KinematicBody2D

onready var target = position

var velocity = Vector2(1,1)
var speed_range = 30
export(float) var speed = 130
export(float) var MAX_FORCE = 0.06

onready var health = get_node("Health Component")
onready var anim_player = get_node("AnimationPlayer")

func _ready():
	
	speed = speed + rand_range(-speed_range, speed_range)
	
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



func _on_Enemy_tree_exiting():
	
	Global.enemies_defeated += 1
	print("Enemies Defeated: " + str(Global.enemies_defeated))
	
	pass
