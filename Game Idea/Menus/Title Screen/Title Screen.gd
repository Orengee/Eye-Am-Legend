extends Node2D

onready var buttons_player = get_node("Buttons Player")

onready var play_button = get_node("Ui Elements/Buttons/Start Game")
onready var settings_button = get_node("Ui Elements/Buttons/Settings")
onready var exit_button = get_node("Ui Elements/Buttons/Exit Game")

onready var tween = get_node("Tween")

func _ready():
	
	var t = Timer.new()
	t.set_wait_time(0.1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	
	buttons_player.play("Default")
	
	pass


