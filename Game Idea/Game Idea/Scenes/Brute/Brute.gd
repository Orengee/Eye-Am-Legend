extends KinematicBody2D

var target = null

var on_cooldown = false

var velocity = Vector2(0,0)
var speed_range = 20
export(float) var speed = 70
var max_speed = 225

onready var health = get_node("Health Component")
onready var tween = get_node("Tween")
onready var charge_radius = get_node("Charge Radius")
onready var timer = get_node("Timer")


func _ready():
	
	speed = 100
	target = Global.player
	
	pass


func _physics_process(delta):
	
	if(on_cooldown == false):
		var move_dir = target.global_position - self.global_position
		velocity = move_dir.normalized() * speed
			
		move_and_slide(velocity)
		
		speed = lerp(speed,max_speed,0.1)
		#NIGHTMARE MODE
		#speed = speed + (health.maximum_value - health.value) / 2
	
	pass


func animate_charge(end_position):
	
	tween.interpolate_property(self,"position",position,end_position,1.3,Tween.TRANS_BACK,Tween.EASE_OUT)
	tween.start()
	on_cooldown = true
	
	timer.start()
	
	pass



func _on_Enemy_tree_exiting():
	
	Global.enemies_defeated += 1
	print("Enemies Defeated: " + str(Global.enemies_defeated))
	
	pass

func _on_Timer_timeout():
	
	
	on_cooldown = false
	speed = 200
	
	pass


func _on_Charge_Radius_body_entered(body):
	
	if(on_cooldown == false):
		if(body.is_in_group("Player")):
			
			speed = 70
			on_cooldown = true
			
			var t = Timer.new()
			t.set_wait_time(2)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			
			
			var direction = target.position - self.position
			var direction_normal = Vector2(direction.x,direction.y).normalized()
			animate_charge(target.position + direction_normal * 40)
		
	
	pass
