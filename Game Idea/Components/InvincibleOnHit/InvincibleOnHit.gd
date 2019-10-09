extends Node2D

var invincible = false
export(float) var invincibility_time
onready var timer = get_node("Timer")

var hitbox

signal invincibility_started
signal invincibility_ended

func _ready():
	
	owner = get_parent()
	timer.wait_time = invincibility_time
	
	#Connect Signals
	if(timer.is_connected("timeout", self, "on_invincibility_timeout") == false):
		timer.connect("timeout", self, "on_invincibility_timeout")
	
	#Connect component signals
	if(owner.has_node("Hurtbox")):
		var component = owner.get_node("Hurtbox")
		hitbox = component
		component.connect("damaged", self, "on_damage_taken")
	
	pass


func start():
	
	invincible = true
	timer.start()
	emit_signal("invincibility_started")
	
	pass


func on_damage_taken(damage):
	
	start()
	hitbox.get_node("Collision").disabled = true
	
	pass


func on_invincibility_timeout():
	
	hitbox.get_node("Collision").disabled = false
	invincible = false
	emit_signal("invincibility_ended")
	timer.stop()
	
	pass