extends Label

var disabled = true

onready var timer = get_node("Timer")

func on_timer_timeout():
	
	#Toggle visibility
	
	if(visible == true):
		visible = false
	else:
		visible = true
	
	timer.start()
	print("BOI")
	
	pass

func disable():
	
	disabled = true
	visible = false
	timer.stop()
	
	pass

func enable():
	
	var t = Timer.new()
	t.set_wait_time(0.1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	
	t.queue_free()
	
	disabled = false
	visible = true
	timer.start()
	
	pass