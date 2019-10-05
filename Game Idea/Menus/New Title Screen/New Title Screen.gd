extends Node2D

func _ready():
	
	#MenuMusic.play("res://Resouces/Audio/title2.ogg")
	
	pass


func _process(delta):
	
	if(Input.is_action_just_pressed("Test")):
		$Transition.animate_fade_out()
	
	if(Input.is_action_just_pressed("Attack")):
		$Transition.animate_fade_in()
