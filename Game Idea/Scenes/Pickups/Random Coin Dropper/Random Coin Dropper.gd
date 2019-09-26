extends Node2D

export(int) var max_value = 4
export(int) var min_value = 1

onready var coin = preload("res://Scenes/Pickups/Coin/Coin.tscn")


func _ready():
	
	var rand_num = int(rand_range(min_value, max_value+1))
	
	for x in rand_num:
		var coin_instance = coin.instance()
		coin_instance.global_position = self.global_position
		Global.world.add_child(coin_instance)
	
	self.queue_free()
	
	pass