extends AnimatedSprite

onready var sfx = preload("res://Tools/Temporary Sound FX/Explosion SFX.tscn")

func _ready():
	
	playing = true
	self.connect("animation_finished",self, "on_finish")
	
	var sfx_instance = sfx.instance()
	Global.world.add_child(sfx_instance)
	
	pass


func on_finish():
	
	queue_free()
	
	pass