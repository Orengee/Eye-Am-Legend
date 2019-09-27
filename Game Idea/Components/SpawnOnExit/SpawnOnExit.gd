extends Node2D

#i love you bean <33333
export(String) var object_path
var parent

func _ready():
	
	parent = get_parent()
	
	parent.connect("tree_exiting", self, "on_owner_exit")
	
	pass

func on_owner_exit():
	
	var object = load(object_path)
	
	#Spawn the instance of the object
	var object_instance = object.instance()
	if(object_instance.get("position") != null):
		object_instance.position = parent.global_position
	if(object_instance.get("rotation") != null):
		object_instance.rotation = parent.rotation
	Global.world.add_child(object_instance)
	
	pass
