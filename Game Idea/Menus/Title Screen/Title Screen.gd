extends Node2D

onready var animation_player = get_node("AnimationPlayer")

func _ready():
	MenuMusic.play("res://Resources/Audio/title2.ogg")
	pass
