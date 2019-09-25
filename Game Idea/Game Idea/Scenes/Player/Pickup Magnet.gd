extends Area2D

func _ready():
	
	if(self.is_connected("area_entered", self, "on_area_entered") == false):
		self.connect("area_entered",self,"on_area_entered")
		
	
	pass


func _process(delta):
	
	
	
	pass


func on_area_entered(area):
	
	if(area.is_in_group("Pickup")):
		area.magnet = true
	
	pass