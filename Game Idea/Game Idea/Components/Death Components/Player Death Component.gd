extends Node2D

var alive = true
onready var parent = get_parent()
onready var game_over_screen = preload("res://Menus/Game Over/Game Over.tscn")

signal death

func death():
	
	#GAME OVER
	emit_signal("death")
	Global.game_over = true
	get_tree().change_scene("res://Menus/Game Over/Game Over.tscn")
	
	pass



func health_depleted():
	
	death()
	
	pass
