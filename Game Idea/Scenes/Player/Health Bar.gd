extends TextureProgress

onready var tween = get_node("Tween")
onready var label = get_node("Label")

var max_health
var health

func _ready():
	
	var health_component = Global.player.get_node("Health Component")
	max_health = health_component.maximum_value
	health = health_component.value
	
	max_value = max_health
	value = max_value
	
	label.text = str(health) + "/" + str(max_health)
	
	pass


func on_health_changed(new_value):
	
	animate_value_change(new_value)
	update_health(new_value)
	
	pass


func update_max_health(new_value):
	
	print("FUCK YEAH")
	
	max_health = new_value
	max_value = max_health
	label.text = str(health) + "/" + str(max_health)
	
	pass


func update_health(new_value):
	
	health = new_value
	label.text = str(health) + "/" + str(max_health)
	
	pass


func animate_value_change(new_value):
	
	tween.interpolate_property(self, "value",self.value, new_value, 0.5,Tween.TRANS_BACK,Tween.EASE_OUT)
	tween.start()
	
	pass