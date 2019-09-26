extends TextureRect

onready var label = get_node("Nuke Amount")

func update_amount(value):
	
	label.text = "x" + str(value)
	
	pass