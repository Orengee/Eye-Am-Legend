extends AudioStreamPlayer2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	volume_db = Settings.MUSIC_VOLUME
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	volume_db = Settings.MUSIC_VOLUME
	pass
