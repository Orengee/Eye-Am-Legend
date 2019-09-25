extends Area2D

var magnet = false
var speed = 0

onready var collision = get_node("Collision")
onready var timer = get_node("Timer")
onready var anim_player = get_node("AnimationPlayer")

func _ready():
	
	anim_player.play("Spin")

	pass


func _process(delta):
	
	if(magnet == true):
		var target = Global.player
		var move_dir = target.global_position - self.global_position
		speed = clamp(speed+15,0,1000)
		position += move_dir.normalized() * speed * delta
	
	pass



func on_body_entered(body):
	
	if(body.is_in_group("Player")):
		
		body.gain_nuke()
		queue_free()
	
	pass