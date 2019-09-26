extends Particles2D

onready var timer = get_node("Timer")

func enable():
	
	emitting = true
	timer.start()
	
	pass


func _on_Timer_timeout():
	
	emitting = false
	
	pass
