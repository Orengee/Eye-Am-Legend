extends Area2D

export(int) var damage
export(String) var target_group
export(bool) var update_after_hit = false

onready var timer = get_node("Timer")
onready var disabled_timer = get_node("DisabledTimer")
onready var collision = get_node("Collision")

signal damaged

func _ready():
	
	#Add to group
	self.add_to_group("Hitbox")
	
	if(timer.is_connected("timeout", self, "on_timer_timeout") == false):
		timer.connect("timeout", self, "on_timer_timeout")
	
	pass


func enable(time):
	
	timer.wait_time = time
	timer.start()
	collision.disabled = false
	
	pass

func disable(time):
	
	disabled_timer.wait_time = time
	disabled_timer.start()
	collision.disabled = true
	
	pass


func on_timer_timeout():
	
	collision.disabled = true
	
	pass


func _on_DisabledTimer_timeout():
	
	collision.disabled = false
	
	pass


func _on_Hitbox_area_entered(area):
	
	if(update_after_hit == true):
		if(area.is_in_group("Hurtbox")):
			if(area.get_parent().is_in_group(target_group)):
				#self.disable(1.1)
				pass
		
	
	pass
