extends StaticBody2D

signal destroyed

onready var gib = preload("res://Scenes/Gib/Gib.tscn")

func _ready():
	
	var grand_parent = get_parent().get_parent()
	
	if(grand_parent.is_in_group("Spawner")):
		
		connect("destroyed", grand_parent.get_parent(), "on_box_destroyed")
	
	pass



func _on_Supply_Box_tree_exiting():
	
	var gib_instance = gib.instance()
	gib_instance.global_position = self.global_position
	Global.world.add_child(gib_instance)
	emit_signal("destroyed")
	
	pass
