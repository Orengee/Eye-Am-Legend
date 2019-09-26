extends Node2D

var current_round = 1
var round_started = false
var round_time = 30 #IN SECONDS

var enemy_spawn_interval = 5 #IN SECONDS
var enemy_spawn_number = 2
var enemy_health_modifier = 0
var enemy_speed_modifier = 0

export(float) var left_limit
export(float) var right_limit
export(float) var top_limit
export(float) var bottom_limit
export(NodePath) var world
var world_node

onready var round_timer = get_node("Round Timer")
onready var spawn_timer = get_node("Spawn Timer")

onready var enemy = preload("res://Scenes/Enemy/Enemy.tscn")
onready var brute = preload("res://Scenes/Brute/Brute.tscn")
onready var explosion = preload("res://Particles/Explosion.tscn")


signal round_complete
signal round_start


func _ready():
	
	round_timer.wait_time = round_time
	spawn_timer.wait_time = enemy_spawn_interval
	
	if(round_timer.is_connected("timeout", self, "round_timer_timeout") == false):
		round_timer.connect("timeout", self, "round_timer_timeout")
	
	if(spawn_timer.is_connected("timeout", self, "spawn_timer_timeout") == false):
		spawn_timer.connect("timeout", self, "spawn_timer_timeout")
	
	world_node = get_node(world)
	
	pass



func round_timer_timeout():
	
	print("ROUND OVER")
	
	round_timer.stop()
	
	#Set up stats for next round
	current_round += 1
	round_time += 5
	round_timer.wait_time = round_time
	
	enemy_health_modifier += 5
	enemy_speed_modifier += 2
	enemy_spawn_interval -= 0.5
	enemy_spawn_number += 1
	
	emit_signal("round_complete", current_round)
	
	pass



func spawn_timer_timeout():
	
	#Restart timer if there is enough time left in the round
	if(round_timer.time_left >= spawn_timer.wait_time):
		spawn_timer.start()
	
	#Spawn the enemies
	spawn_enemies(enemy_spawn_number)
	
	pass



func start_round():
	
	print("START ROUND")
	
	emit_signal("round_start")
	round_timer.start()
	spawn_timer.start()
	
	pass



func spawn_enemies(num):
	
	for x in num:
		#Find random position of enemy to spawn
		var x_value = rand_range(left_limit,right_limit)
		var y_value = rand_range(top_limit,bottom_limit)
	
		var spawn_position = Vector2(x_value,y_value)
	
		#Create enemy instance
		var enemy_instance = enemy.instance()
		enemy_instance.position = spawn_position
		enemy_instance.speed += enemy_speed_modifier
		enemy_instance.get_node("Health Component").value += enemy_health_modifier
		var explosion_instance = explosion.instance()
		explosion_instance.position = spawn_position
		explosion_instance.z_index = 3
	
		world_node.add_child(explosion_instance)
		world_node.add_child(enemy_instance)
	
	pass
