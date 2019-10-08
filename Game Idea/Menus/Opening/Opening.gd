extends Node2D

onready var timer = get_node("Timer")
onready var tween = get_node("Tween")

var scene = 1

func _ready():
	
	timer.start()
	MenuMusic.play("res://Resources/Audio/title2.ogg")
	print("yeet")
	pass


func _input(event):
	
	#SKIP
	if((event is InputEventKey and event.pressed) or (event is InputEventMouseButton and event.pressed)):
		if(event.is_action("Fullscreen") == false):
			MenuMusic._player.seek(42.6666)
			get_tree().change_scene("res://Menus/Title Screen/Title Screen.tscn")


func fade_out(scene):
	
	tween.interpolate_property(scene,"modulate",Color(1,1,1,1),Color(1,1,1,0),0.3,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	tween.start()
	
	pass
	
	
func fade_in(scene):
	
	tween.interpolate_property(scene,"modulate",Color(1,1,1,0),Color(1,1,1,1),0.5,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	tween.start()
	
	pass


func _on_Timer_timeout():
	
	fade_out(get_node(str(scene)))
	scene += 1
	
	if(scene == 9):
		get_tree().change_scene("res://Menus/Title Screen/Title Screen.tscn")
		
	
	if(scene < 9):
		fade_in(get_node(str(scene)))
	
	timer.start()
	
	pass
