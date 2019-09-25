extends Node2D

export(float) var shake_power
export(float) var shake_duration
onready var timer = get_node("Timer")

var shaking = false

func _ready():
	
	timer.wait_time = shake_duration
	
	if(timer.is_connected("timeout", self, "on_screen_shake_timer_timeout") == false):
		timer.connect("timeout", self, "on_screen_shake_timer_timeout")
	
	pass


func _process(delta):
	
	if(shaking):
		shake()
	
	pass


func get_current_camera():
	
	var cameras = get_tree().get_nodes_in_group("Camera")
	for camera in cameras:
		if(camera.current == true):
			return camera
	
	return null
	
	pass


func start():
	
	shaking = true
	timer.start()
	
	pass

func starto(value):
	
	shaking = true
	timer.start()
	
	pass


func shake():
	
	#Set timer wait time
	timer.wait_time = shake_duration
	
	#Get current_camera
	var camera = get_current_camera()
	if(camera != null):
		camera.set_offset(Vector2(rand_range(-1.0,1.0) * shake_power, 0))
	
	
	pass
	
	
func on_screen_shake_timer_timeout():
	
	shaking = false
	
	pass
	

func trigger_shake():
	shake()



func start_():
	pass # Replace with function body.
