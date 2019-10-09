extends KinematicBody2D

export(float) var PERCEPTION_RADIUS = 300

onready var target = position

var velocity = Vector2(1,1)
var speed_range = 50
export(float) var speed = 60
var min_speed = 40
export(float) var MAX_FORCE = 0.1
export(float) var MAX_SEPARTION_FORCE = 8

onready var health = get_node("Health Component")
onready var anim_player = get_node("AnimationPlayer")
onready var tween = get_node("Tween")

onready var shader = preload("res://WhiteShader.tres")

const death_sfx = preload("res://Tools/Temporary Sound FX/Temp Sound FX.tscn")

func _ready():
	
	Global.enemies.append(self)
	speed = speed + rand_range(0, speed_range)
	
	
	min_speed = speed - 10
	
	pass


func _physics_process(delta):
	
	target = Global.player.position
	var steering = Vector2(0,0)
	steering += steer(target)
	steering += separate(Global.enemies)
	
	if(velocity.length() < min_speed):
		var normal = velocity.normalized()
		velocity = normal * min_speed
	
	velocity = steering
	move_and_slide(velocity)
	
	
	#NIGHTMARE MODE
	if(Settings.nightmare == true):
		#speed = speed + (health.maximum_value - health.value) / 3
		speed = (Global.player.maximum_speed + Global.player.speed_bonus)
		min_speed = speed - 10
	
	
	pass



func steer(target : Vector2) -> Vector2:
	var helper= (target - get_position()).normalized() * speed
	var desired_velocity = Vector2(helper.x, helper.y)
	var steer = desired_velocity - velocity
	var target_velocity = velocity + (steer * MAX_FORCE )
	return target_velocity



#Steer away from surrounding boids at a strength inversly proportional
#to the distance from said boid
func separate(boids) -> Vector2:
	
	var steering_velocity = Vector2(0,0)
	var total_boids = 0
	
	for boid in boids:
		
		var distance = self.position.distance_to(boid.position)
		
		#Check if boid is self or if its inside radius
		if(boid != self and distance < PERCEPTION_RADIUS-30):
			
			#Calculate difference in positions
			var difference = self.position - boid.position
			
			#Change the strength to be inversly proportional
			if(distance > 0):
				difference = difference/distance
			
			steering_velocity += difference
			total_boids += 1
	
	#Make sure we actually detected a boid to avoid /0
	if(total_boids > 0):
		
		#Find average velocity and calculate steering
		steering_velocity = steering_velocity/total_boids
		
		#Make sure all boids run at max speed
		if(steering_velocity.length() < 100):
			
			var normal = steering_velocity.normalized()
			steering_velocity = normal * 100
		
		steering_velocity = steering_velocity - self.velocity
		steering_velocity = steering_velocity.clamped(MAX_SEPARTION_FORCE)
	
	return steering_velocity
	
	pass



func animate_hit():
	
	tween.interpolate_property($Sprite,"scale",Vector2(1.45,1.45),Vector2(1,1),0.7,Tween.TRANS_BACK,Tween.EASE_OUT)
	tween.start()
	
	pass


func _on_Enemy_tree_exiting():
	
	Global.enemies.erase(self)
	
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
