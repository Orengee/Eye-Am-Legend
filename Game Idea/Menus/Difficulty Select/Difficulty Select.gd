extends Node2D

onready var camera_shake = get_node("Camera Shake")
onready var transition_timer = get_node("Transition Timer")
onready var back_timer = get_node("Back Timer")
onready var SFX = get_node("SFX")

func _ready():
	
	$Transition.cutoff = 1.0
	$Transition.animate_fade_in()
	
	pass

func load_normal_mode():
	
	$Transition.animate_fade_out()
	Settings.nightmare = false
	button_press()
	transition_timer.start()

func load_nightmare_mode():
	
	$Transition.animate_fade_out()
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


func _on_Back_Button_pressed():
	
	button_press()
	$Transition.animate_fade_out()
	back_timer.start()
	
	pass


func _on_Back_Timer_timeout():
	
	get_tree().change_scene("res://Menus/Title Screen/Title Screen.tscn")
	
	pass
