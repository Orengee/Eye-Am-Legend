extends Node2D

export(NodePath) var world
var world_node

export(float) var left_limit
export(float) var right_limit
export(float) var top_limit
export(float) var bottom_limit

export(float) var spawn_interval = 5


onready var timer = get_node("Timer")
onready var enemy = preload("res://Scenes/Enemy/Enemy.tscn")
onready var explosion = preload("res://Particles/Explosion.tscn")


func _ready():
	
	world_node = get_node(world)
	
	timer.wait_time = spawn_interval
	timer.connect("timeout",self,"on_timer_timeout")
	timer.start()
	
	pass


func spawn_enemy():
	
	print("SPAWN")
	
	#Find random position of enemy to spawn
	var x_value = rand_range(left_limit,right_limit)
	var y_value = rand_range(top_limit,bottom_limit)
	
	var spawn_position = Vector2(x_value,y_value)
	
	#Create enemy instance
	var enemy_instance = enemy.instance()
	enemy_instance.position = spawn_position
	var explosion_instance = explosion.instance()
	explosion_instance.position = spawn_position
	explosion_instance.z_index = 3
	
	world_node.add_child(explosion_instance)
	world_node.add_child(enemy_instance)
	
	pass


func on_timer_timeout():
	
	spawn_enemy()
	
	pass


