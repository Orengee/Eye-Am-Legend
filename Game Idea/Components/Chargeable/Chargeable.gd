extends Node2D

export(float) var full_charge_time = 1
var charging = false
var min_charge_percent = 0.0
var current_charge_percent = 0

onready var timer = get_node("Timer")

signal charge_completed
signal charge_released

func _ready():
	
	timer.wait_time = full_charge_time
	
	if(timer.is_connected("timeout", self, "on_timer_timeout") == false):
		
		timer.connect("timeout", self, "on_timer_timeout")
		
		pass
	
	pass


func start():
	
	timer.start()
	charging = true
	
	pass


func _process(delta):
	
	current_charge_percent = (timer.wait_time-timer.time_left)/timer.wait_time
	
	if(Input.is_action_just_pressed("Attack")):
		print("START")
		start()
	
	if(Input.is_action_just_released("Attack")):
		timer.stop()
		charging = false
		if(current_charge_percent > min_charge_percent):
			emit_signal("charge_released", current_charge_percent)
	
	pass


func on_timer_timeout():
	
	timer.stop()
	emit_signal("charge_completed")
	
	pass
