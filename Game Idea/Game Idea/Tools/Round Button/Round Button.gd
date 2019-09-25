extends Area2D

var is_down = false

onready var sprite = get_node("Sprite")

signal pushed


func ready():
	
	if(self.is_connected("body_entered",self,"on_body_entered") == false):
		self.connect("body_entered",self,"on_body_entered")
	
	pass

func on_body_entered(body):
	
	print("OWO ENTERED")
	
	if(is_down == false):
		if(body.is_in_group("Player")):
			print("PUSHED")
			sprite.modulate.a = 0.4
			is_down = true
			emit_signal("pushed")
	
	pass

func on_round_end(wave):
	
	is_down = false
	sprite.modulate.a = 1
	
	pass

