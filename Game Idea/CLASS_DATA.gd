extends Node

#CLASS DATA

onready var airstrike_skill = preload("res://Scenes/Skills/Airstrike Skill/Airstrike Skill.tscn")
onready var blink_skill = preload("res://Scenes/Skills/Blink Skill/Blink Skill.tscn")
onready var sentry_skill = preload("res://Scenes/Skills/Sentry Skill/Sentry Skill.tscn")

enum CLASS{
	
	mage = 0,
	soldier = 1,
	engineer = 2
	
}

var CLASSES


func _ready():
	
	CLASSES = {
	
		CLASS.mage : {
			
			skill = blink_skill
			
		},
		CLASS.soldier : {
			
			skill = airstrike_skill
			
		},
		CLASS.engineer : {
			
			skill = sentry_skill
			
		}
	
}
	
	Global.player_class = CLASSES[CLASS.mage]["skill"]
	
	pass



