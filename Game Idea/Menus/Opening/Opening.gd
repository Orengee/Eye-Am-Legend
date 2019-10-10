extends Node2D

onready var opanim = get_node("opanim")
onready var skipanim = get_node("skipanim")

var scene = 1

func _ready():
	
	MenuMusic.play("res://Resources/Audio/title2.ogg")
	opanim.play("opening")
	
	pass


func _input(event):
	
	if event is InputEventKey and event.scancode == KEY_SPACE :
		MenuMusic._player.seek(42.6666)
		get_tree().change_scene("res://Menus/Title Screen/Title Screen.tscn")
	elif((event is InputEventKey and event.pressed) or (event is InputEventMouseButton and event.pressed)) : 
		skipanim.play("skip")
		
	pass

func _on_opanim_animation_finished(anim_name):
	
	get_tree().change_scene("res://Menus/Title Screen/Title Screen.tscn")
	
	pass
