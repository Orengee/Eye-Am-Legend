extends Node2D

export(PackedScene) var pickup = preload("res://Scenes/Pickups/Coin/Coin.tscn")

export(int) var max_value = 4
export(int) var min_value = 1


func _ready():
	
	var rand_num = int(rand_range(min_value, max_value+1))
	
	for x in rand_num:
		var pickup_instance = pickup.instance()
		pickup_instance.global_position = self.global_position
		Global.world.add_child(pickup_instance)
	
	self.queue_free()
	
	pass