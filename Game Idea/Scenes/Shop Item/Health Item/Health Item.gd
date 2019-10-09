extends "res://Scenes/Shop Item/Shop Item.gd"

onready var health_pickup = preload("res://Scenes/Pickups/Health Pickup/Health Pickup.tscn")

func _ready():
	
	._ready()
	text_notification = "+Health"
	
	pass

func effect():
	
	price = floor(price * 1.2)
	
	var health_instance = health_pickup.instance()
	health_instance.global_position = self.global_position
	Global.world.add_child(health_instance)
	
	pass