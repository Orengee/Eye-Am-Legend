extends Area2D

var speed = 900
var damage = 0

onready var hitbox = get_node("Hitbox")
onready var knockback = get_node("Knockback Sender")
onready var sprite = get_node("Sprite")

func _ready():
	
	if(is_connected("body_entered",self,"on_body_entered") == false):
		connect("body_entered", self, "on_body_entered")
	
	hitbox.damage = damage
	
	pass

func _process(delta):
	
	move(delta)
	
	pass

func move(delta):
	
	var direction = Vector2(sin(rotation), -cos(rotation))
	position += direction * speed * delta
	
	pass
	
func on_body_entered(body):
	
	if(body.is_in_group("Enemy")):
		pass
	
	pass
	
func explode():
	hitbox.enable(0.1)
	knockback.enable(0.1)
	var object = load("res://Particles/Explosion.tscn")
	
	#Spawn the instance of the object
	var object_instance = object.instance()
	object_instance.position = global_position
	object_instance.rotation = rotation
	Global.world.add_child(object_instance)
	
	sprite.queue_free();
	#self.queue_free()
	pass

func _on_Fuse_timeout():
	explode()
	pass
