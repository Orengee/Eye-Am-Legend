extends Area2D

export(int) var value = 1

var magnet = false
var speed = 0

onready var collision = get_node("Collision")
onready var timer = get_node("Timer")
onready var anim_player = get_node("AnimationPlayer")
onready var anim_sprite = get_node("AnimatedSprite")
onready var spawn_anim_player = get_node("Spawn Animation Player")
onready var tween = get_node("Tween")

func _ready():
	
	anim_player.play("spin")
	spawn_anim_player.play("Jump")
	anim_sprite.playing = true
	
	connect("body_entered",self, "on_body_entered")
	timer.connect("timeout", self, "on_timer_timeout")
	timer.start()
	
	#Go in random direction
	var rand_angle = rand_range(-180,180)
	var direction = Vector2(cos(rand_angle), -sin(rand_angle))
	var end_position = global_position + (direction * 20)
	tween.interpolate_property(self,"global_position",global_position,end_position,0.5,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	tween.start()
	
	pass


func _process(delta):
	
	if(magnet == true):
		var target = Global.player
		var move_dir = target.global_position - self.global_position
		
		var image_angle = move_dir.angle() + deg2rad(90)
		$AnimatedSprite.rotation = lerp($AnimatedSprite.rotation,image_angle,0.05)
		
		speed = clamp(speed+15,0,1000)
		position += move_dir.normalized() * speed * delta
	
	pass


func on_timer_timeout():
	
	collision.disabled = false
	
	pass



func on_body_entered(body):
	
	if(body.is_in_group("Player")):
		body.wallet_component.raise_value(value)
		queue_free()
	
	pass