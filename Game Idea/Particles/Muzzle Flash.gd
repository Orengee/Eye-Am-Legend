extends Particles2D

onready var timer = get_node("Timer")

func _ready():
	
	timer.connect("timeout", self, "on_timer_timeout")
	
	emitting = true
	
	pass


func enable():
	
	emitting = true
	timer.start()
	
	pass


func on_timer_timeout():
	
	emitting = false
	
	pass