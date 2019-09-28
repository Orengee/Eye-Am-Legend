extends Area2D

#Detects damaging collisions or "hitboxes"
onready var collision = get_node("Collision")
onready var parent = get_parent()
onready var tween = get_node("Tween")
var disabled = false

signal damaged

func _ready():
	
	#Connect signals for detecting collisions
	if(is_connected("area_entered", self,"on_area_entered") == false):
		connect("area_entered", self, "on_area_entered")
	
	
	owner = get_parent()
	#Check for signals from relevant components
	if(owner.has_node("InvincibleOnHit")):
		var component = owner.get_node("InvincibleOnHit")
		component.connect("invincibility_started", self, "on_invincibility_start")
		component.connect("invincibility_ended", self, "on_invincibility_end")
	
	
	#Add to hurtbox group
	self.add_to_group("Hurtbox")
	
	pass

func on_area_entered(area):
	
	if(disabled == false):
		#Check if the collision was from a hitbox
		if(area.is_in_group("Hitbox")):
			#A hit has been taken: signal that damage has been taken
			if(parent.is_in_group(area.target_group)):
				
				#Assign damage information
				var damage_taken = area.damage
				#Emit signal
				emit_signal("damaged", damage_taken)
				#Play a hit effect
				flash_white()
				
		
	pass


func flash_white():
	
	tween.interpolate_property(owner, "modulate", Color(100,100,100,100), Color(1,1,1,1),0.1,Tween.TRANS_LINEAR,Tween.EASE_IN)
	tween.start()
	
	pass


func squash_and_stretch():
	
	pass


func on_invincibility_start():
	
	disabled = true
	
	pass


func on_invincibility_end():
	
	disabled = false
	
	pass
