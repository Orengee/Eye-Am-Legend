extends StaticBody2D

signal destroyed

func _ready():
	
	var grand_parent = get_parent().get_parent()
	
	if(grand_parent.is_in_group("Spawner")):
		
		connect("destroyed", grand_parent.get_parent(), "on_box_destroyed")
	
	pass



func _on_Supply_Box_tree_exiting():
	
	emit_signal("destroyed")
	
	pass
