extends Node2D

onready var _player = get_node("Menu Music")

func _ready():
	
	_player.volume_db = Settings.MUSIC_VOLUME
	
	pass


func _process(delta):
	
	_player.volume_db = Settings.MUSIC_VOLUME
	
	pass


func play(resource_path : String):
	
	var track = load(resource_path)
	_player.stream = track
	_player.play()
	set_process(true)
	
	pass
	
func stop():
	
	_player.stop()
	set_process(false)
	
	pass
