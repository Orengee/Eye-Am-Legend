extends TextureRect

onready var tween = get_node("Tween")
onready var label = get_node("Label")

func update_wave(new_wave):
	
	label.text = str(new_wave)
	
	pass

