extends Area2D

export(int) var damage
export(String) var target_group

onready var timer = get_node("Timer")
onready var collision = get_node("Collision")

func _ready():
	
	#Add to group
	self.add_to_group("Hitbox")
	
	if(timer.is_connected("timeout", self, "on_timer_timeout") == false):
		timer.connect("timeout", self, "on_timer_timeout")
	
	pass


func enable(time):
	
	timer.wait_time = time
	timer.start()
	collision.disabled = false
	
	pass


func on_timer_timeout():
	
	collision.disabled = true
	
	pass
