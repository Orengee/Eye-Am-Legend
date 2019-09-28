extends Node2D

var wave = 0

export(int) var spawn_limit = 20

export(int) var spawn_box_width = 1
export(int) var spawn_box_height = 1

onready var round_start_timer = get_node("Round Start Timer")
onready var spawn_positions = get_node("Spawn Positions")
onready var grunt_timer = get_node("Grunt Timer")
onready var brute_timer = get_node("Brute Timer")

onready var explosion = preload("res://Particles/Explosion.tscn")
onready var grunt = preload("res://Scenes/Enemy/Enemy.tscn")
onready var brute = preload("res://Scenes/Brute/Brute.tscn")


signal wave_started
signal wave_ended


enum ENEMY_TYPE{
	
	grunt,
	flyer,
	brute,
	bomber
	
}

var health_bonus = 0
var speed_bonus = 0

var in_wave = false
var enemies_per_wave = 10
var enemies_spawned = 0

var grunts_per_wave = 10
var grunts_per_spawn = 3
var grunt_spawn_interval = 2
var spawned_grunts = 0


var flyers_per_wave = 0
var flyers_per_spawn = 0
var flyer_spawn_iterval = 0
var spawned_flyer = 0


var brutes_per_wave = 0
var brutes_per_spawn = 1
var brute_spawn_interval = 10
var spawned_brute = 0


var bombers_per_wave = 0
var bombers_per_spawn = 0
var bomber_spawn_interval = 0
var spawned_bomber = 0



func _ready():
	
	if(grunt_timer.is_connected("timeout", self, "on_grunt_timer_timeout") == false):
		grunt_timer.connect("timeout", self, "on_grunt_timer_timeout")
	
	if(brute_timer.is_connected("timeout", self, "on_brute_timer_timeout") == false):
		brute_timer.connect("timeout", self, "on_brute_timer_timeout")
	
	round_start_timer.connect("timeout", self, "on_round_timer_timeout")
	enemies_per_wave = grunts_per_wave + flyers_per_wave + brutes_per_wave + bombers_per_wave
	
	print("YOUR DREAMS CAN COME TRUE")
	grunt_timer.wait_time = grunt_spawn_interval
	
	brute_timer.wait_time = brute_spawn_interval
	
	start_wave()
	
	pass


func _process(delta):
	
	if(Global.enemies_defeated == enemies_per_wave):
		stop_wave()
		Global.enemies_defeated = 0
	
	pass


func get_random_spawn():
	
	var num_of_spawn_positions = spawn_positions.get_child_count()
	var rand_index = rand_range(0,num_of_spawn_positions-1)
	
	return spawn_positions.get_child(rand_index)
	
	pass


func start_wave():
	
	if(wave > 0):
		if(Settings.nightmare == false):
			Global.player.music_active()
	
	print("WAVE START")
	#Update Stats
	wave += 1
	
	if(Settings.nightmare == false):
	
		health_bonus += 1
		speed_bonus += 5
		grunts_per_spawn += 1
		grunts_per_wave += 5
	else:
		health_bonus += 6
		speed_bonus += 5
		grunts_per_wave += 9
		grunts_per_spawn += 1
	
	#Things to happen every other round

	if(wave % 5 == 0):
		
		brutes_per_wave += 1
		
		pass
	
	enemies_per_wave = grunts_per_wave
	enemies_spawned = 0
	
	spawned_grunts = 0
	spawned_flyer = 0
	spawned_brute = 0
	spawned_bomber = 0
	
	grunt_timer.start()
	if(brutes_per_wave > 0):
		brute_timer.start()
	emit_signal("wave_started", wave)
	
	print("EPW: " + str(enemies_per_wave))
	
	pass


func stop_wave():
	
	if(Settings.nightmare == false):
		
		Global.player.music_passive()
	
	grunt_timer.stop()
	round_start_timer.start()
	
	pass


func spawn_grunt():
	if(spawned_grunts - Global.enemies_defeated <= spawn_limit):
		
		if(spawned_grunts < grunts_per_wave):
			
			var spawn_number = grunts_per_spawn
			
			if(grunts_per_spawn > grunts_per_wave-spawned_grunts):
				spawn_number = (grunts_per_wave-spawned_grunts)
			
			for x in spawn_number:
				
				#Create grunts and pick random spawn positions
				
				var rand_position_location = get_random_spawn().global_position
				var rand_box_width_offset = rand_range(-spawn_box_width,spawn_box_width)
				var rand_box_height_offset = rand_range(-spawn_box_height,spawn_box_height)
				var rand_position = rand_position_location + Vector2(rand_box_width_offset,rand_box_height_offset)
				
				var grunt_instance = grunt.instance()
				grunt_instance.position = rand_position
				grunt_instance.speed += speed_bonus
				var health_component = grunt_instance.get_node("Health Component")
				health_component.value += health_bonus
				health_component.maximum_value = health_component.value
				grunt_instance.z_index = 2
				
				var explosion_instance = explosion.instance()
				explosion_instance.global_position = rand_position
				
				Global.world.add_child(grunt_instance)
				Global.world.add_child(explosion_instance)
				
				spawned_grunts += 1
				enemies_spawned += 1
			
			
	pass

func spawn_brute():
	
	if(spawned_brute < brutes_per_wave):
		
		var spawn_number = brutes_per_spawn
		
		if(brutes_per_spawn > brutes_per_wave-spawned_brute):
			spawn_number = (brutes_per_wave-spawned_brute)
		
		for x in spawn_number:
			
			#Create grunts and pick random spawn positions
			
			var rand_position = get_random_spawn().global_position
			var grunt_instance = brute.instance()
			grunt_instance.position = rand_position
			grunt_instance.speed += speed_bonus
			grunt_instance.get_node("Health Component").value
			grunt_instance.z_index = 2
			
			var explosion_instance = explosion.instance()
			explosion_instance.global_position = rand_position
			
			Global.world.add_child(grunt_instance)
			Global.world.add_child(explosion_instance)
			
			spawned_brute += 1
			enemies_spawned += 1
			
			
	pass


func on_grunt_timer_timeout():
	
	spawn_grunt()
	
	if(spawned_grunts < grunts_per_wave):
		grunt_timer.start()
	
	pass


func on_brute_timer_timeout():
	
	
	spawn_brute()
	if(spawned_brute < brutes_per_wave):
		brute_timer.start()
		
	pass



func on_round_timer_timeout():
	
	start_wave()
	
	pass


