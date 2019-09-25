extends Area2D

export(int) var amount = 5
var magnet = false

onready var anim_player = get_node("AnimationPlayer")
var sfx = preload("res://Tools/Temporary Sound FX/Health Pickup SFX.tscn")

func _ready():
	
	self.connect("body_entered",self,"on_body_entered")
	anim_player.play("spin")
	
	pass


func on_body_entered(body):
	
	if(body.is_in_group("Player")):
		
		var sfx_instance = sfx.instance()
		Global.world.add_child(sfx_instance)
		
		body.health_component.raise_value(amount)
		self.queue_free()
	
	pass