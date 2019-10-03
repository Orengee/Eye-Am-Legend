extends Node2D

var price_multiplier = 1

var health_up = preload("res://Scenes/Shop Item/Health Up Item/Health Up Item.tscn")
var reload_up = preload("res://Scenes/Shop Item/Reload Up Item/Reload Up Item.tscn")
var spare_trigger = preload("res://Scenes/Shop Item/Spare Trigger/Spare Trigger.tscn")
var sprint_up = preload("res://Scenes/Shop Item/Sprint Up Item/Sprint Up Item.tscn")
var triple_barrel = preload("res://Scenes/Shop Item/Triple Barrel/Triple Barrel.tscn")

var explosion = preload("res://Particles/Explosion.tscn")

var items = [health_up,reload_up,spare_trigger,sprint_up,triple_barrel]

onready var shop_position_1 = get_node("Shop Position 1")
onready var shop_position_2 = get_node("Shop Position 2")
onready var shop_position_3 = get_node("Shop Position 3")

func _ready():
	
	randomize()
	
	#Pick 3 random shop items (none are duplicates)
	var indexs = []
	
	while(indexs.size() < 3):
		var rand_index = int(rand_range(0,items.size()))
		if(indexs.has(rand_index) == false):
			indexs.append(rand_index)
	
	#Instance and place all shop items
	var item_0 = items[indexs[0]].instance()
	item_0.position = shop_position_1.position
	item_0.price *= price_multiplier
	item_0.connect("bought",self,"on_shop_item_bought")
	var item_1 = items[indexs[1]].instance()
	item_1.position = shop_position_2.position
	item_1.price *= price_multiplier
	item_1.connect("bought",self,"on_shop_item_bought")
	var item_2 = items[indexs[2]].instance()
	item_2.position = shop_position_3.position
	item_2.price *= price_multiplier
	item_2.connect("bought",self,"on_shop_item_bought")
	
	self.add_child(item_0)
	self.add_child(item_1)
	self.add_child(item_2)
	
	pass


func on_shop_item_bought():
	
	queue_free()
	
	pass


func _on_Random_Shop_tree_exiting():
	
	var explosion_1 = explosion.instance()
	var explosion_2 = explosion.instance()
	var explosion_3 = explosion.instance()
	
	explosion_1.global_position = $"Shop Position 1".global_position
	explosion_2.global_position = $"Shop Position 2".global_position
	explosion_3.global_position = $"Shop Position 3".global_position
	
	Global.world.add_child(explosion_1)
	Global.world.add_child(explosion_2)
	Global.world.add_child(explosion_3)
	
	pass
