extends Particles2D

onready var anim_player = get_node("AnimationPlayer")

func _ready():
	
	z_index = -3
	emitting = true
	anim_player.play("Base")
	
	pass
