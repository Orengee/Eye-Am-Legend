extends Node2D

export(int) var maximum_value = 50
export(int) var value = maximum_value setget set_value

export(bool) var enable_regen = false   #Enables regen feature (does not turn regen on and off)
export(float) var regen_delay = 0.0     #How long after taking a hit regen begins
export(float) var regen_rate = 0.0     #How long passes inbetween each regen "surge"
export(float) var regen_amount = 0.0    #How much you regen each "surge"
var regen_active = false

onready var regen_delay_timer = get_node("Regen Delay")
onready var regen_timer = get_node("Regen Timer")

onready var parent = get_parent()

signal value_lowered
signal value_raised
signal value_depleted
signal value_changed

signal regen_started
signal regen_stopped


func _ready():
	
	if(enable_regen == true):
		regen_timer.wait_time = regen_rate
		regen_delay_timer.wait_time = regen_delay
	
	if(regen_timer.is_connected("timeout", self, "regen_timeout") == false):
		regen_timer.connect("timeout", self, "regen_timeout")
	if(regen_delay_timer.is_connected("timeout", self, "regen_delay_timeout") == false):
		regen_delay_timer.connect("timeout", self, "regen_delay_timeout")
	
	var parent_nodes = parent.get_children()
	
	for node in parent_nodes:
		if(node.is_in_group("CDeath")):
			connect("value_depleted", node, "health_depleted")
		elif(node.is_in_group("Hurtbox")):
			node.connect("damaged",self, "damage_taken")
		
	
	pass



func raise_value(new_value):
	
	var sum = value + new_value
	
	if(sum > maximum_value):
		value = maximum_value
	else:
		value = sum
	
	emit_signal("value_raised", sum)
	
	pass



func lower_value(new_value):
	
	var difference = value - new_value
	
	if(difference <= 0):
		value = 0
		
		emit_signal("value_depleted")
	else:
		value = difference
	
	emit_signal("value_lowered", difference)
	
	if(enable_regen == true):
		regen_delay_timer.start()
	
	pass



func regen():
	
	raise_value(regen_amount)
	
	if(value >= maximum_value):
		regen_active = false
	
	if(regen_active == true):
		regen_timer.start()
	
	pass



func regen_delay_timeout():
	
	regen_active = true
	emit_signal("regen_started")
	regen()
	
	pass



func regen_timeout():
	
	regen()
	if(value >= maximum_value):
		regen_active = false
		emit_signal("regen_stopped")
	else:
		regen_timer.start()
	
	pass



func damage_taken(damage):
	
	lower_value(damage)
	
	pass


func set_value(new_value):
	
	value = new_value
	emit_signal("value_changed", new_value)
	
	pass

