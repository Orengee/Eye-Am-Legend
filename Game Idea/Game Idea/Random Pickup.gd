extends Node2D

export(Array) var item_paths
export(float) var drop_chance = 0 #That an item (any item) will drop

func _ready():
	
	#Roll chance for item to drop
	var rand_num = randf()
	if(rand_num <= drop_chance):
		
		print("ITEM SPAWN")
		#Choose random item
		var rand_index = int(rand_range(0,item_paths.size()))
		
		#Create item
		create_pickup(item_paths[rand_index])
		
		pass
	else:
		queue_free()
	
	pass


func create_pickup(item_path):
	
	#Get item
	var pickup = load(item_path)
	var pickup_instance = pickup.instance()
	pickup_instance.global_position = self.global_position
	
	#add to world
	Global.world.add_child(pickup_instance)
	
	#Delete self
	self.queue_free()
	
	pass

