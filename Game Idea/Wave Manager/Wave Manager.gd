extends Node2D

var wave = 0

export(int) var spawn_limit = 43

export(int) var spawn_box_width = 1
export(int) var spawn_box_height = 1

onready var round_start_timer = get_node("Round Start Timer")
onready var spawn_positions = get_node("Spawn Positions")
onready var grunt_timer = get_node("Grunt Timer")
onready var brute_timer = get_node("Brute Timer")
onready var flyer_timer = get_node("Flyer Timer")

onready var explosion = preload("res://Particles/Explosion.tscn")
onready var grunt = preload("res://Scenes/Enemy/Enemy.tscn")
onready var brute = preload("res://Scenes/Brute/Brute.tscn")
onready var flyer = preload("res://Scenes/Flyer/Flyer.tscn")
onready var sfx = get_node("SFX")

onready var round_notifier = preload("res://Round Notifier.tscn")
onready var random_shop = preload("res://Scenes/Random Shop/Random Shop.tscn")
onready var shop_notifier = preload("res://Scenes/UI/Shop Notifier/Shop Notifier.tscn")

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

var grunts_per_wave = 15
var grunts_per_spawn = 3
var grunt_spawn_interval = 2.5
var spawned_grunts = 0


var flyers_per_wave = 0
var flyers_per_spawn = 0
var flyer_spawn_interval = 5
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
	
	if(flyer_timer.is_connected("timeout", self, "on_flyer_timer_timeout") == false):
		flyer_timer.connect("timeout", self, "on_flyer_timer_timeout")
	
	round_start_timer.connect("timeout", self, "on_round_timer_timeout")
	enemies_per_wave = grunts_per_wave + flyers_per_wave
	
	print("YOUR DREAMS CAN COME TRUE")
	grunt_timer.wait_time = grunt_spawn_interval
	
	brute_timer.wait_time = brute_spawn_interval
	
	flyer_timer.wait_time = flyer_spawn_interval
	
	
	var t = Timer.new()
	t.set_wait_time(6.1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	
	start_wave()
	
	pass


func _process(delta):
	
	if(Global.enemies_defeated == enemies_per_wave):
		enemies_per_wave = 0
		stop_wave()
	
	pass


func get_random_spawn():
	
	var num_of_spawn_positions = spawn_positions.get_child_count()
	var rand_index = rand_range(0,num_of_spawn_positions-1)
	
	return spawn_positions.get_child(rand_index)
	
	pass


func start_wave():
	
	
	sfx._play()
	Global.enemies_defeated = 0
	
	if(wave > 0):
		Global.player.music_active()
	
	#Update Stats
	wave += 1
	var round_notifier_instance = round_notifier.instance()
	Global.world.add_child(round_notifier_instance)
	
	if(Settings.nightmare == false):
	
		
		speed_bonus = clamp(speed_bonus + 4,0,20)
		grunts_per_spawn += 1
		grunts_per_wave += 7
	else:
		health_bonus += 6
		speed_bonus += clamp(speed_bonus + 7,0,20)
		grunts_per_wave += 9
		grunts_per_spawn += 1
	
	if(wave % 2 == 0):
		
		health_bonus += 1
		
		pass
	
	if(wave == 3):
		
		flyers_per_wave += 1
		flyers_per_spawn += 1
		grunts_per_wave += 1
		
		pass
	
	if(wave > 3 and (wave % 2) == 0):
		
		flyers_per_wave += 1
		
		pass
	
		
		pass
	
	enemies_per_wave = grunts_per_wave + flyers_per_wave
	enemies_spawned = 0
	
	spawned_grunts = 0
	spawned_flyer = 0
	spawned_brute = 0
	spawned_bomber = 0
	
	grunt_timer.start()
	if(flyers_per_wave > 0):
		flyer_timer.start()
	emit_signal("wave_started", wave)
	
	print("WAVE START")
	print("-----EPW: " + str(enemies_per_wave))
	
	pass


func stop_wave():
		
	Global.player.music_passive()
	
	if(wave % 3 == 0):
		var shop_instance = random_shop.instance()
		shop_instance.global_position = $"Shop Location".global_position
		
		var notifier_instance = shop_notifier.instance()
		
		var explosion_instance = explosion.instance()
		explosion_instance.global_position = $"Shop Location".global_position
		
		Global.world.add_child(notifier_instance)
		Global.world.add_child(shop_instance)
		Global.world.add_child(explosion_instance)
	
	grunt_timer.stop()
	round_start_timer.start()
	print("WAVE STOP")
	
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
				
				spawn_effect(rand_position)
				
				Global.world.add_child(grunt_instance)
				
				spawned_grunts += 1
				enemies_spawned += 1
			
			
	pass


func spawn_flyer():
	if(spawned_flyer < flyers_per_wave):
			
		var spawn_number = flyers_per_spawn
			
		if(flyers_per_spawn > flyers_per_wave-spawned_flyer):
			spawn_number = (flyers_per_wave-spawned_flyer)
			
		for x in spawn_number:
				
			#Create grunts and pick random spawn positions
				
			var rand_position_location = get_random_spawn().global_position
			var rand_box_width_offset = rand_range(-spawn_box_width,spawn_box_width)
			var rand_box_height_offset = rand_range(-spawn_box_height,spawn_box_height)
			var rand_position = rand_position_location + Vector2(rand_box_width_offset,rand_box_height_offset)
			
			var grunt_instance = flyer.instance()
			grunt_instance.position = rand_position
			grunt_instance.speed += speed_bonus
			var health_component = grunt_instance.get_node("Health Component")
			health_component.value += health_bonus
			health_component.maximum_value = health_component.value
			grunt_instance.z_index = 2
				
			spawn_effect(rand_position)
				
			Global.world.add_child(grunt_instance)
				
			spawned_flyer += 1
			enemies_spawned += 1
			
			
	pass


func spawn_effect(position):
	
	var explosion_instance = explosion.instance()
	explosion_instance.sfx_volume -= 12
	explosion_instance.global_position = position
	
	pass


func on_grunt_timer_timeout():
	
	spawn_grunt()
	
	if(spawned_grunts < grunts_per_wave):
		grunt_timer.start()
	
	pass


func on_flyer_timer_timeout():
	
	spawn_flyer()
	if(spawned_flyer < flyers_per_wave):
		flyer_timer.start()
	
	pass


func on_round_timer_timeout():
	
	start_wave()
	
	pass


