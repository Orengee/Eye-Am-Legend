extends Node2D

export(Vector2) var effect_scale
export(String) var object_path

func spawn(spawn_position):
	
	var object = load(object_path)
	var object_instance = object.instance()
	object_instance.position = spawn_position
	object_instance.scale = effect_scale
	object_instance.rotation = get_parent().rotation
	Global.game.add_child(object_instance)
	
	pass