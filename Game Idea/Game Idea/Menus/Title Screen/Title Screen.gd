extends Node2D

onready var animation_player = get_node("AnimationPlayer")

func _ready():
	animation_player.play("Player_Idle")
	$"Pedestal Player".play("float")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
