extends Node2D

export(float) var duration = 1

var on_cooldown = false

onready var timer = get_node("Timer")

signal cooldown_started
signal cooldown_finished

func _ready():
	
	timer.wait_time = duration
	
	if(timer.is_connected("timeout", self, "timeout") == false):
		timer.connect("timeout", self, "timeout")
	
	pass


func start():
	
	on_cooldown = true
	timer.start()
	emit_signal("cooldown_started")
	
	pass



func stop():
	
	on_cooldown = false
	emit_signal("cooldown_finished")
	
	pass



func timeout():
	
	stop()
	
	pass
