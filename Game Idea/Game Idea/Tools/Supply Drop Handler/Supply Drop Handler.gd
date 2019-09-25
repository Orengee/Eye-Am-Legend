extends Node2D

export(int) var supply_drop_interval = 30
var drop_on_the_field = false

onready var timer = get_node("Timer")
onready var spawn_locations = get_node("Spawn Locations")

var supply_box = preload("res://Scenes/Supply Box/Supply Box.tscn")
var explosion = preload("res://Particles/Explosion.tscn")


signal countdown_updated


func _ready():
	
	timer.wait_time = supply_drop_interval
	timer.start()
	
	pass



func _process(delta):
	
	emit_signal("countdown_updated", timer.time_left)
	
	pass



func on_box_destroyed():
	
	drop_on_the_field = false
	timer.start()
	
	pass



func spawn_box():
	
	#Get random_spawn
	var num_of_spawn_positions = spawn_locations.get_child_count()
	var rand_index = rand_range(0,num_of_spawn_positions)
	
	var spawn_location = spawn_locations.get_child(rand_index)
	
	var explosion_instance = explosion.instance()
	
	var box_instance = supply_box.instance()
	
	spawn_location.add_child(explosion_instance)
	spawn_location.add_child(box_instance)
	
	drop_on_the_field = true
	
	pass



func _on_Timer_timeout():
	
	timer.stop()
	spawn_box()
	
	
	pass
