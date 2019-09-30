extends Node2D

export(float) var reload_time = 1

var reloading = false
var reload_percent = 0
var disabled = false
var clip_empty = false

var clip_node

onready var timer = get_node("Timer")
onready var progress_bar = get_node("ProgressBar")

onready var sound_fx = get_node("SFX")


signal reload_started
signal reload_complete

func _ready():
	
	timer.wait_time = reload_time
	
	if(timer.is_connected("timeout", self, "on_timer_timeout") == false):
		timer.connect("timeout", self, "on_timer_timeout")
	
	var parent_nodes = get_parent().get_children()
	
	for node in parent_nodes:
		if(node.is_in_group("CClip")):
			clip_node = node
	
	
	pass


func _input(event):
	if(disabled == false):
		if(event.is_action_pressed("Reload") and reloading == false):
			start()
	
	if(clip_empty == true and disabled == false):
		if(event.is_action_pressed("Attack") and reloading == false):
			start()



func _process(delta):
	
	if(clip_node != null):
		if(clip_node.rounds_left <= 0):
			clip_empty = true
	
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
	sound_fx._play()
	reloading = true
	timer.start()
	
	pass


func on_timer_timeout():
	
	reloading = false
	clip_empty = false
	emit_signal("reload_complete")
	
	pass


func disable():
	
	disabled = true

func enable():
	
	disabled = false

