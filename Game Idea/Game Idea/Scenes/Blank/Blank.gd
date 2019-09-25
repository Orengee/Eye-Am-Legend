extends Node2D

onready var timer = get_node("Timer")


func _ready():
	
	timer.connect("timeout", self, "on_timer_timeout")
	print("JKASHFKJAHSFJKAHSFJ B L A N K")
	timer.start()
	
	pass


func on_timer_timeout():
	
	self.queue_free()
	
	pass