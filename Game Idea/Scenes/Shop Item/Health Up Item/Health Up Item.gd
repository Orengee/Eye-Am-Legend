extends "res://Scenes/Shop Item/Shop Item.gd"

#Raise Player maximum health
export(int) var health_increase = 20

func _ready():
	
	._ready()
	text_notification = "+Maximum Health"
	
	pass

func effect():
	
	var health_component = Global.player.get_node("Health Component")
	health_component.raise_maximum_value(health_increase)
	health_component.value = health_component.maximum_value
	
	pass