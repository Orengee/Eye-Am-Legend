extends Node2D

signal round_used
signal ammo_changed
signal clip_empty
signal clip_refilled

func on_round_used(rounds):
	
	if(rounds <= 0):
		emit_signal("clip_empty")
	
	emit_signal("round_used", rounds)
	
	pass


func on_ammo_changed(new_ammo):
	
	emit_signal("ammo_changed", new_ammo)
	emit_signal("clip_refilled")
	
	pass

