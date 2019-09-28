extends Node2D

onready var cooldown = get_node("Cooldown Component")


func _process(delta):
	
	if(Input.is_action_just_pressed("Activate Skill")):
		
		use_skill()
		
		pass
	
	pass


#Uses skill and sets up cooldowns for it
func use_skill():
	
	if(cooldown.on_cooldown == false):
		
		skill()
		cooldown.start()
		
		pass
	
	pass


#Executes skill functionality
func skill():
	
	#Skill logic
	
	pass