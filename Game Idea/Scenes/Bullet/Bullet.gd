extends Area2D

var speed = 900
var damage = 0
var targets_hit = 0

export(int) var piercing = 1
export(int) var speed_range = 50
onready var hitbox = get_node("Hitbox")
onready var hit_effect = preload("res://Particles/Hit Effect.tscn")



func _ready():
	
	var rand_speed = rand_range(-speed_range,speed_range)
	speed += rand_speed
	
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


func create_hit_effect():
	
	var hit_effect_instance = hit_effect.instance()
	hit_effect_instance.global_position = self.global_position
	hit_effect_instance.z_index += 1
	Global.world.add_child(hit_effect_instance)
	
	pass


func on_body_entered(body):
	
	create_hit_effect()
	
	if(body.is_in_group("Wall")):
		queue_free()
	
	if(body.is_in_group("Enemy")):
		targets_hit += 1
		if(targets_hit >= piercing):
			queue_free()
	
	pass