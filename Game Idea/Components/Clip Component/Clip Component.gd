extends Node2D

export(int) var clip_size = 10
export(int) var rounds_left = clip_size
var clip_empty = false

export(int) var maximum_ammo = 120
export(int) var reserve_ammo = clip_size

signal clip_empty
signal clip_refilled
signal round_changed
signal ammo_refilled

signal empty

func _ready():
	
	var grand_parent = get_parent().get_parent()
	
	if(grand_parent.name == "Weapon"):
		connect("round_changed",grand_parent,"on_round_used")
		connect("clip_refilled",grand_parent,"on_ammo_changed")
	
	if(rounds_left <= 0):	
		emit_signal("clip_empty")
	
	pass


func set_rounds_left(value):
	
	if(value >= clip_size):
		rounds_left = clip_size
		return
	
	if(value <= 0):
		rounds_left = 0
		clip_empty = true
		emit_signal("clip_empty")
		return
	
	rounds_left = value
	
	
	pass


func get_rounds_left():
	
	return rounds_left
	
	pass


func on_round_used():
	
	set_rounds_left(rounds_left - 1)
	if(rounds_left <= 0 and reserve_ammo <= 0):
		emit_signal("empty")
	emit_signal("round_changed",rounds_left)
	
	pass



func refill_ammo(percent):
	
	var ammo_percent = percent
	var ammo_restored = floor(maximum_ammo * ammo_percent)
	print(ammo_percent)
	print(ammo_restored)
	
	if(reserve_ammo + ammo_restored > maximum_ammo):
		reserve_ammo = maximum_ammo
	else:
		reserve_ammo += ammo_restored
	
	emit_signal("ammo_refilled")
	
	emit_signal("clip_refilled", reserve_ammo)
	
	pass



func refill_clip():
	
	if(reserve_ammo >= clip_size-rounds_left):
		
		reserve_ammo = reserve_ammo - (clip_size - rounds_left)
		rounds_left = clip_size
		
	else:
		rounds_left += reserve_ammo
		reserve_ammo = 0
	
	emit_signal("round_changed",rounds_left)
	emit_signal("clip_refilled", reserve_ammo)
	
	pass
