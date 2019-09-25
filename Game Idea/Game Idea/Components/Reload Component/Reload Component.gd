extends Node2D

export(float) var reload_time = 1

var reloading = false
var reload_percent = 0
var disabled = false

onready var timer = get_node("Timer")
onready var progress_bar = get_node("ProgressBar")

signal reload_started
signal reload_complete

func _ready():
	
	timer.wait_time = reload_time
	
	if(timer.is_connected("timeout", self, "on_timer_timeout") == false):
		timer.connect("timeout", self, "on_timer_timeout")
	
	pass


func _input(event):
	if(disabled == false):
		if(event.is_action_pressed("Reload") and reloading == false):
			start()



func _process(delta):
	
	if(reloading == true):
		progress_bar.visible = true
		reload_percent = (timer.wait_time-timer.time_left)/timer.wait_time
		progress_bar.value = reload_percent
	else:
		progress_bar.visible = false
		progress_bar.value = 0
	
	pass


func start():
	
	emit_signal("reload_started")
	reloading = true
	timer.start()
	
	pass


func on_timer_timeout():
	
	reloading = false
	emit_signal("reload_complete")
	
	pass


func disable():
	
	disabled = true

func enable():
	
	disabled = false

