extends Node2D

onready var hitbox = get_node("Hitbox")
onready var knockback_sender = get_node("Knockback Sender")
onready var despawn_timer = get_node("Despawn Timer")

onready var explosion = preload("res://Particles/Explosion.tscn")

func _on_Timer_timeout():
	
	hitbox.enable(0.1)
	knockback_sender.enable(0.1)
	
	var explosion_instance = explosion.instance()
	explosion_instance.global_position = self.global_position
	Global.world.add_child(explosion_instance)
	
	despawn_timer.start()
	
	pass


func _on_Despawn_Timer_timeout():
	
	queue_free()
	
	pass
