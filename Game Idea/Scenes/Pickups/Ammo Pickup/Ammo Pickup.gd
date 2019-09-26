extends Area2D

var amount = 1

var magnet = false
var speed = 0

var shell_sprite_1 = load("res://Resources/pistol_shell.png")
var shell_sprite_2 = load("res://Resources/shotgun_shell.png")

onready var temp_sfx = preload("res://Tools/Temporary Sound FX/Weapon Pickup.tscn")

func _ready():
	
	amount = int(rand_range(1,4))
	$Sprite.rotation_degrees += rand_range(-50,50)
	
	var rand_index = floor(rand_range(0,2))
	print(rand_index)
	if(rand_index == 1):
		$Sprite.texture = shell_sprite_1
	else:
		$Sprite.texture = shell_sprite_2
	
	pass

func _process(delta):
	
	if(magnet == true):
		var target = Global.player
		var move_dir = target.global_position - self.global_position
		
		var image_angle = move_dir.angle() + deg2rad(90)
		$Sprite.rotation = lerp($Sprite.rotation,image_angle,0.05)
		$Shadow.rotation = lerp($Shadow.rotation,image_angle,0.05)
		
		speed = clamp(speed+5,0,1100)
		position += move_dir.normalized() * speed * delta
	
	pass

func _on_Ammo_Pickup_body_entered(body):
	
	if(body.is_in_group("Player")):
		
		var sfx_instance = temp_sfx.instance()
		Global.world.add_child(sfx_instance)
		
		body.ammo_pickup(amount)
		queue_free()
		
		pass
	
	pass
