extends Node2D

func _ready():
	Global.world = self
	get_tree().paused = false
	pass
