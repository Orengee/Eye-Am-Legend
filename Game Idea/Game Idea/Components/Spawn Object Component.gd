extends Node2D

export(PackedScene) var object
export(NodePath) var spawn_path
onready var spawn_node
export(NodePath) var rotation_path
onready var rotation_node
export(String) var trigger

onready var parent = get_parent()

func _ready():
	
	spawn_node = get_node(spawn_path)
	rotation_node = get_node(rotation_path)
	parent.connect(trigger, self, "on_trigger")
	
	pass


func on_trigger():
	
	
	var object_instance = object.instance()
	
	if(spawn_node == null):
		object_instance.position = parent.global_position
	else:
		object_instance.position = spawn_node.global_position
	
	if(rotation_node == null):
		object_instance.rotation = parent.rotation
	else:
		object_instance.rotation = rotation_node.rotation
		
	Global.world.add_child(object_instance)
	
	
	pass

