extends TextureProgress

onready var tween = get_node("Tween")

func on_health_changed(new_value):
	
	animate_value_change(new_value)
	
	pass


func animate_value_change(new_value):
	
	tween.interpolate_property(self, "value",self.value, new_value, 0.5,Tween.TRANS_BACK,Tween.EASE_OUT)
	tween.start()
	
	pass