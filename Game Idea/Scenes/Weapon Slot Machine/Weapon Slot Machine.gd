extends "res://Scenes/Shop Item/Shop Item.gd"

var tommy_gun = preload("res://Scenes/Weapons/Tommy Gun/Tommy Gun.tscn")
var pistol = preload("res://Scenes/Weapons/Pistol/Pistol.tscn")
var grenade_launcher = preload("res://Scenes/Weapons/Grenade Launcher/Grenade Launcher.tscn")
var sword = preload("res://Scenes/Weapons/Swords/Sword.tscn")
var hand_cannon = preload("res://Scenes/Weapons/Hand Cannon/Hand Cannon.tscn")
var shotgun = preload("res://Scenes/Weapons/Shotgun/Shotgun.tscn")
var megaphone = preload("res://Scenes/Weapons/Megaphone/Megaphone.tscn")
var marshmallow_gun = preload("res://Scenes/Weapons/Marshmallow Gun/Marshmallow Gun.tscn")
var machine_pistol = preload("res://Scenes/Weapons/Machine Pistol/Machine Pistol.tscn")
var frisbee_gun = preload("res://Scenes/Weapons/Frisbee Gun/Frisbee Gun.tscn")
var cactus_gun = preload("res://Scenes/Weapons/Cactus Gun/Cactus Gun.tscn")
var magic_missile = preload("res://Scenes/Weapons/Magic Missile/Magic Missile.tscn")
var scrap_gun = preload("res://Scenes/Weapons/Scrap Gun/Scrapgun.tscn")

onready var weapon_pickup = preload("res://Scenes/Weapon Pickup/Weapon Pickup.tscn")
onready var spawn_location = get_node("Spawn Location")
onready var animated_sprite = get_node("Sprites/Slot Machine")

var weapon_pool = [tommy_gun,megaphone,marshmallow_gun,machine_pistol,
magic_missile,scrap_gun,grenade_launcher,shotgun,frisbee_gun,
hand_cannon,cactus_gun,sword]

onready var slot_timer = get_node("Timer")
var weapon_pool_size

var rolling = false

export(float) var roll_time = 5

signal roll_start
signal roll_end

func _ready():
	
	randomize()
	weapon_pool_size = weapon_pool.size()
	
	animated_sprite.playing = false
	
	slot_timer.wait_time = roll_time
	slot_timer.connect("timeout", self, "on_timer_timeout")
	
	pass


func buy(buyer):
	
	var buyer_wallet = buyer.wallet_component
	var wallet_value = buyer_wallet.value
	
	if(wallet_value >= price):
		
		buyer_wallet.lower_value(price)
		times_bought += 1
		effect()
		price_label.text = str(price)
		animate_interaction()
		emit_signal("bought")
		emit_signal("upgraded", times_bought)
		
		if(one_time_buy == true):
			queue_free()
		
	else:
		
		print("WHAT KINDA SHOP DO YA THINK IM RUNNING")
	
	pass


func effect():
	
	animate_interaction()
	animated_sprite.playing = true
	roll()
	
	pass


func animate_interaction():
	
	tween.interpolate_property(self,"scale",Vector2(2,2),Vector2(1.5,1.5),1,Tween.TRANS_BACK,Tween.EASE_OUT)
	tween.start()
	
	pass


func roll():
	
	emit_signal("roll_start")
	
	if(rolling == false):
		slot_timer.start()
		rolling = true
	
	pass


func spawn_weapon():
	
	if(spawn_location.get_child(0) != null):
		var child = spawn_location.get_child(0)
		child.queue_free()
	
	var rand_weapon_index = rand_range(0,weapon_pool_size)
	
	var weapon_pickup_instance = weapon_pickup.instance()
	
	weapon_pickup_instance.weapon_preload = weapon_pool[rand_weapon_index]
	
	var weapon_instance = weapon_pool[rand_weapon_index].instance()
	var weapon_sprite = weapon_instance.find_node("Sprite")
	var weapon_texture_path = weapon_sprite.texture.resource_path
	var weapon_texture = load(weapon_texture_path)
	weapon_pickup_instance.get_node("Sprite").texture = weapon_texture
	weapon_instance.queue_free()
	
	spawn_location.add_child(weapon_pickup_instance)
	
	rolling = false
	
	pass


func on_timer_timeout():
	
	spawn_weapon()
	emit_signal("roll_end")
	animated_sprite.playing = false
	
	pass