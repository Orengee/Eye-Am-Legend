extends StaticBody2D

signal destroyed

onready var tween = get_node("Tween")
onready var gib = preload("res://Scenes/Gib/Gib.tscn")
onready var shader = preload("res://WhiteShader.tres")

func _ready():
	
	var grand_parent = get_parent().get_parent()
	
	if(grand_parent.is_in_group("Spawner")):
		
		connect("destroyed", grand_parent.get_parent(), "on_box_destroyed")
	
	pass



func flash_white():
	
	$Sprite.material = shader
	
	var t = Timer.new()
	t.set_wait_time(0.1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	
	$Sprite.material = null
	
	t.queue_free()
	
	pass


func animate_hit():
	
	tween.interpolate_property($Sprite,"scale",Vector2(1.3,1.3),Vector2(1,1),0.7,Tween.TRANS_BACK,Tween.EASE_OUT)
	tween.start()
	
	pass


func _on_Hurtbox_damaged(damage):
	
	animate_hit()
	flash_white()
	
	Engine.time_scale = 0.6
	var t = Timer.new()
	t.set_wait_time(0.06)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	Engine.time_scale = 1
	
	
	t.queue_free()
	
	pass



func _on_Supply_Box_tree_exiting():
	
	Engine.time_scale = 1
	var gib_instance = gib.instance()
	gib_instance.global_position = self.global_position
	Global.world.add_child(gib_instance)
	emit_signal("destroyed")
	
	pass
