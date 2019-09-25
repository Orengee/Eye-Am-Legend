extends TextureRect

onready var label = get_node("Label")

func update_amount(value):
	
	label.text = "x" + str(value)
	
	pass