extends ColorRect

export(float) var fade_out_time = 2
export(float) var fade_in_time = 1
var cutoff = 0.0

onready var tween = get_node("Tween")

func _process(delta):
	
	material.set("shader_param/cutoff", cutoff)
	
	pass


func animate_fade_out():
	
	tween.interpolate_property(self,"cutoff",0.0,1.0,fade_out_time,Tween.TRANS_SINE,Tween.EASE_OUT)
	tween.start()
	
	pass

func animate_fade_in():
	
	tween.interpolate_property(self,"cutoff",cutoff,0.0,fade_in_time,Tween.TRANS_SINE,Tween.EASE_OUT)
	tween.start()
	
	pass