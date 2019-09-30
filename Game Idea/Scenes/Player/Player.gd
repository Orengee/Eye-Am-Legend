extends KinematicBody2D

var maximum_speed = 135
var maximum_sprinting_speed = 210
var speed_weight = 0.3
var tilt_angle = 10
var tilt_weight = 0.1
var sprinting = false

var velocity = Vector2(0,0)

var input_direction = Vector2(0,0)
var move_direction = Vector2(0,0)
var facing_right = true

var paused = false

export(int) var damage_bonus = 0
export(int) var speed_bonus = 0

onready var body = get_node("Body")
onready var weapon_node = get_node("Weapon")
onready var animation_player = get_node("AnimationPlayer")
onready var wallet_component = get_node("Wallet Component")
onready var health_component = get_node("Health Component")
onready var tween = get_node("Tween")
onready var music_player = get_node("Music")
onready var music_player_2 = get_node("Music2")
onready var weapon_switch_timer = get_node("Weapon Switch Timer")
onready var skill = get_node("Skill")

onready var regular_music = preload("res://Resources/Audio/gameplay1 (1).ogg")
onready var nightmare_music = preload("res://Resources/Audio/nightmare.ogg")
onready var nightmare_music_passive = preload("res://Resources/Audio/nightmare_p.ogg")
var music_1_playing = true


var current_weapon_index = 0

var weapon_data = {
	
	0 : {
		
		packedscene = preload("res://Scenes/Weapons/Pistol/Pistol.tscn"),
		name = "Pistol",
		clip = 0,
		ammo = 0
		
	},
	1 : {
		
		packedscene = preload("res://Scenes/Weapons/Pistol/Pistol.tscn"),
		name = "Pistol",
		clip = 0,
		ammo = 0
		
	}
	
}



signal nuke_used
signal weapon_loaded


func _ready():
	
	Global.player = self
	animation_player.play("Idle")
	weapon_switch_timer.start()
	
	#Set up starting weapon data
	current_weapon_index = 1
	new_weapon(preload("res://Scenes/Weapons/Pistol/Pistol.tscn"))
	current_weapon_index = 0
	new_weapon(preload("res://Scenes/Weapons/Swords/Sword.tscn"))
	load_weapon()
	
	#Add skill
	var skill_node = Global.player_class.instance()
	skill.add_child(skill_node)
	
	if(Settings.nightmare == true):
		Settings.MUSIC_VOLUME *= 1.5
		music_player.stream = nightmare_music
		music_player_2.stream = nightmare_music_passive
		
	else:
		Settings.MUSIC_VOLUME *= 1
		music_player.stream = regular_music
	
	
	
	pass

func _input(event):
	
	if(event is InputEventMouseButton):
		
		if(event.is_pressed()):
			
			if(weapon_switch_timer.is_stopped() == true):
				if(event.button_index == BUTTON_WHEEL_UP):
					next_weapon()
					pass
				if(event.button_index == BUTTON_WHEEL_DOWN):
					previous_weapon()
					pass
					
	if(event.is_action_pressed("Sprint")):
		sprinting = true
	if(event.is_action_released("Sprint")):
		sprinting = false
	
	pass


func _physics_process(delta):
	
	
	#Get input for running and update direction variables
	var HORIZONTAL = int(Input.is_action_pressed("Right")) - int(Input.is_action_pressed("Left"))
	var VERTICAL = int(Input.is_action_pressed("Down")) - int(Input.is_action_pressed("Up"))
	
	if(sprinting == false):
		velocity.x = lerp(velocity.x, HORIZONTAL * (maximum_speed + speed_bonus) , speed_weight)
		velocity.y = lerp(velocity.y, VERTICAL * (maximum_speed + speed_bonus) , speed_weight)
	else:
		velocity.x = lerp(velocity.x, HORIZONTAL * (maximum_sprinting_speed + speed_bonus) , speed_weight)
		velocity.y = lerp(velocity.y, VERTICAL * (maximum_sprinting_speed + speed_bonus) , speed_weight)
	
	#Update variables
	input_direction = Vector2(HORIZONTAL, VERTICAL)
	move_direction = Vector2(sign(velocity.x),sign(velocity.y))
	
	if(input_direction.x > 0):
		body.scale.x = 1
		facing_right = true
	elif(input_direction.x < 0):
		body.scale.x = -1
		facing_right = false
	
	#Apply tilt
	body.rotation_degrees = lerp(body.rotation_degrees,tilt_angle * input_direction.x, tilt_weight)
	
	move_and_slide(velocity, Vector2(0,0))





func load_weapon():
	
	#Delete current weapon
	if(weapon_node.get_child(0) != null):
		var weapon = weapon_node.get_child(0)
		weapon.queue_free()
	
	#Load in weapon of the current weapon index
	var new_weapon = weapon_data[current_weapon_index]["packedscene"].instance()
	
	#Check if weapon has a clip_component
	if(weapon_data[current_weapon_index]["clip"] >= 0):
		#Load clip and ammo data
		var weapon_clip = new_weapon.get_node("Clip Component")
		weapon_clip.rounds_left = weapon_data[current_weapon_index]["clip"]
		weapon_clip.reserve_ammo = weapon_data[current_weapon_index]["ammo"]
	
	#Emit signals
	var clip_amount = weapon_data[current_weapon_index]["clip"]
	var ammo_amount = weapon_data[current_weapon_index]["ammo"]
	emit_signal("weapon_loaded",clip_amount,ammo_amount)
	
	#Add to scene
	weapon_node.add_child(new_weapon)
	
	pass



func save_weapon(weapon_index):
	
	var weapon = weapon_node.get_child(0)
	
	if(weapon_data[current_weapon_index]["clip"] >= 0):
		
		var weapon_clip = weapon.get_node("Clip Component")
		weapon_data[weapon_index]["clip"] = weapon_clip.rounds_left
		weapon_data[weapon_index]["ammo"] = weapon_clip.reserve_ammo
		
		pass
	
	pass



func new_weapon(packedscene):
	
	#Check if weapon has clip
	#If so grab the clip and ammo data
	#Else set clip and ammo to -1
	
	var weapon = packedscene.instance()
	
	#Set weapon packedscene data
	weapon_data[current_weapon_index]["packedscene"] = packedscene
	
	#Check for clip component
	if weapon.has_node("Clip Component") == false:
		
		weapon_data[current_weapon_index]["clip"] = -1
		weapon_data[current_weapon_index]["ammo"] = -1
	
	else:
		
		var clip_component = weapon.get_node("Clip Component")
		weapon_data[current_weapon_index]["clip"] = clip_component.rounds_left
		weapon_data[current_weapon_index]["ammo"] = clip_component.reserve_ammo
	
	#Delete weapon instance
	weapon.queue_free()
	
	
	pass


func next_weapon():
	
	save_weapon(current_weapon_index)
	
	#Clear out current weapon
	var current_weapon = weapon_node.get_child(0)
	current_weapon.queue_free()
	
	#Find next weapon index
	var weapon_list_size = weapon_data.size()
	if(current_weapon_index + 1 >= weapon_list_size):
		current_weapon_index = 0
	else:
		current_weapon_index += 1
	
	
	load_weapon()
	
	weapon_switch_timer.start()
	
	pass


func previous_weapon():
	
	save_weapon(current_weapon_index)
	
	#Clear out current weapon
	var current_weapon = weapon_node.get_child(0)
	current_weapon.queue_free()
	
	#Find next weapon index
	var weapon_list_size = weapon_data.size()
	if(current_weapon_index - 1 < 0):
		current_weapon_index = weapon_list_size-1
	else:
		current_weapon_index -= 1
	
	
	#Add in next weapon in list
	load_weapon()
	
	weapon_switch_timer.start()
	
	pass


func ammo_pickup(amount):
	
	if(weapon_node.get_child(0) != null):
		var weapon = weapon_node.get_child(0)
		if(weapon.has_node("Clip Component")):
			
			var weapon_clip = weapon.get_node("Clip Component")
			weapon_clip.refill_ammo(amount)
			
			pass
		else:
			return
	
	pass

	
func music_passive():
	
	if(music_1_playing):
		
		fade_out_track(music_player,2)
		fade_in_track(music_player_2,-9)
		
		pass
	
	pass

func music_active():
		
	fade_out_track(music_player_2,-9)
	fade_in_track(music_player,2)
	
	pass
	

func fade_out_track(music_node,start_volume):
	
	tween.interpolate_property(music_node,"volume_db",start_volume,-50,5,Tween.TRANS_QUINT,Tween.EASE_IN)
	tween.start()
	
	pass

func fade_in_track(music_node,final_volume):
	
	tween.interpolate_property(music_node,"volume_db",-50,final_volume,3,Tween.TRANS_CIRC,Tween.EASE_OUT)
	tween.start()
	
	pass

