extends Node2D

var alive = true
onready var parent = get_parent()

signal death



func death():
	
	emit_signal("death")
	parent.queue_free()
	
	pass



func health_depleted():
	
	death()
	
	pass
