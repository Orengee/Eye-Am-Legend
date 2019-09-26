extends HSlider

func _ready():
	min_value = 0.0001
	step = 0.0001
	pass

func _process(delta):
	
	
	
	Settings.MUSIC_VOLUME = log(value) * 20
	
	pass
