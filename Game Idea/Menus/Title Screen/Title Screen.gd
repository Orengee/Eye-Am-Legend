extends Node2D

onready var animation_player = get_node("AnimationPlayer")

func _ready():
	animation_player.play("Player_Idle")
	$"Pedestal Player".play("float")
	MenuMusic.play("res://Resources/Audio/title2.ogg")
	pass
