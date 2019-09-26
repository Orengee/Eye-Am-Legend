extends "res://Scenes/Bullet/Bullet.gd"

onready var anim_player = get_node("AnimationPlayer")
onready var animation_timer = get_node("Animation Timer")

func _ready():
	
	._ready()
	
	animation_timer.wait_time == $Temporary.duration - 0.25
	animation_timer.start()
	
	pass



func _on_Animation_Timer_timeout():
	
	print("TADA")
	anim_player.play("Disappear")
	
	pass
