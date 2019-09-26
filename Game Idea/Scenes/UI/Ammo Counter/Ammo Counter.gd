extends TextureRect

var clip = 0
var total_ammo = 0

onready var label = get_node("Ammo Count")


func update_all(clip_value, ammo_value):
	
	update_clip(clip_value)
	update_total_ammo(ammo_value)
	update_text()
	
	pass


func update_clip(clip_value):
	
	clip = clip_value
	update_text()
	
	pass

func update_total_ammo(ammo_value):
	
	total_ammo = ammo_value
	update_text()
	
	pass

func update_text():
	
	$"Ammo Count".text = str(clip) + "/" + str(total_ammo)
	
	pass



func update_ammo():
	pass # Replace with function body.
