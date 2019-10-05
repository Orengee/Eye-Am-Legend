extends Node2D

func _ready():
	
	$CanvasLayer/Transition.cutoff = 1.0
	$CanvasLayer/Transition.animate_fade_in()
	
	Global.world = self
	get_tree().paused = false
	MenuMusic.stop()
	
	pass
	
