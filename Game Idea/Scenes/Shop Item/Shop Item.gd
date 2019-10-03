extends Area2D

export(int) var price = 10
export(bool) var one_time_buy = false
var times_bought = 0

onready var price_label = get_node("Label")
onready var tween = get_node("Tween")
onready var tooltip = get_node("Tooltip")
var sprite

signal bought
signal upgraded

func _ready():
	
	price_label.text = str(price)
	
	if(self.is_connected("body_entered",self,"on_body_entered") == false):
		self.connect("body_entered", self, "on_body_entered")
	
	sprite = get_node("Sprite")
	
	pass



func buy(buyer):
	
	var buyer_wallet = buyer.wallet_component
	var wallet_value = buyer_wallet.value
	
	if(wallet_value >= price):
		
		buyer_wallet.lower_value(price)
		times_bought += 1
		effect()
		price_label.text = str(price)
		animate_interaction()
		emit_signal("bought")
		emit_signal("upgraded", times_bought)
		
		if(one_time_buy == true):
			queue_free()
		
	else:
		
		print("WHAT KINDA SHOP DO YA THINK IM RUNNING")
	
	pass


func effect():
	
	pass


func animate_interaction():
	
	tween.interpolate_property($Sprite,"scale",Vector2(1.5,1.5),Vector2(1,1),1,Tween.TRANS_BACK,Tween.EASE_OUT)
	tween.start()
	
	pass


func on_body_entered(body):
	
	if(body.is_in_group("Player")):
		
		buy(body)
		
		pass
	
	pass

func _on_Shop_Item_mouse_entered():
	
	if(tooltip != null):
		tooltip.visible = true
	
	pass


func _on_Shop_Item_mouse_exited():
	
	if(tooltip != null):
		tooltip.visible = false
	
	pass
