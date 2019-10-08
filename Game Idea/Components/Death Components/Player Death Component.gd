extends Node2D

var alive = true
onready var parent = get_parent()
onready var game_over_screen = preload("res://Menus/Game Over/Game Over.tscn")
const explosion = preload("res://Particles/Explosion.tscn")

onready var death_sound = get_node("Death Sound")
onready var timer = get_node("Timer")
onready var knockback_sender = get_node("Knockback Sender")

onready var player = get_parent()

signal death

func death():
	
	#GAME OVER
	emit_signal("death")
	Global.game_over = true
	
	player.music_player.playing = false
	player.music_player_2.playing = false
	
	knockback_sender.enable(0.1)
	
	death_sound.play()
	#player.set_physics_process(false)
	if(player.weapon_node.get_child(0) != null):
		player.weapon_node.get_child(0).queue_free()
	Engine.time_scale = 0.4
	
	if(player.animation_player.current_animation != "Death"):
		player.animation_player.play("Death")

	timer.start()
	
	
	pass



func change_scene():
	
	get_tree().change_scene("res://Menus/Game Over/Game Over.tscn")
	
	pass



func health_depleted():
	
	death()
	
	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	
	if(anim_name == "Death"):
		
		var head = player.get_node("Body/Head")
		
		if(head != null):
			var explosion_instance = explosion.instance()
			explosion_instance.position = head.position
			player.add_child(explosion_instance)
			
			player.head.queue_free()
	
	pass


func _on_Timer_timeout():
	
	change_scene()
	
	pass
