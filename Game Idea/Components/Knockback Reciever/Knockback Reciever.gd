extends Area2D

var velocity = Vector2(0,0)
export(float) var friction = 0.2


func _ready():
	
	if(self.is_connected("area_entered", self, "on_area_entered") == false):
		self.connect("area_entered", self, "on_area_entered")
	
	pass


func _physics_process(delta):
	
	get_parent().move_and_slide(velocity)
	
	if(velocity.x != 0):
		velocity.x = lerp(velocity.x,0,friction)
	if(velocity.y != 0):
		velocity.y = lerp(velocity.y,0,friction)



func on_area_entered(area):
	
	if(area.is_in_group("Knockback Sender")):
		
		#Calculate knockback vector
		var knock_dir = self.global_position - area.global_position
		velocity = knock_dir.normalized() * area.get("knockback_force")
		
		#Start knockback timer so it cant continuously take kb
		
	
	
	pass