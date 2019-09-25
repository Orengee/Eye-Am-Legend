extends Node2D

onready var camera_shake = get_node("Camera Shake")
onready var transition_timer = get_node("Transition Timer")
onready var SFX = get_node("SFX")

func load_normal_mode():
	Settings.nightmare = false
	button_press()
	transition_timer.start()

func load_nightmare_mode():
	Settings.nightmare = true
	button_press()
	transition_timer.start()

func button_press():
	
	camera_shake.start()
	SFX.play()
	
	pass


func _on_Transition_Timer_timeout():
	
	get_tree().change_scene("res://World.tscn")
	
	pass
