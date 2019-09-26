extends Node

#Object exists for a set duration of time
export(float) var duration = 0.0
onready var timer = get_node("Timer")

func _ready():
	
	timer.wait_time = duration
	timer.start()
	
	if(timer.is_connected("timeout", self, "on_timer_timeout") == false):
		timer.connect("timeout", self, "on_timer_timeout")
	
	pass


func on_timer_timeout():
	
	get_parent().queue_free()
	
	pass
