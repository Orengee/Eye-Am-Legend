extends Node2D

func _ready():
	
	$Transition.cutoff = 1.0
	$Transition.animate_fade_in()
	
	pass