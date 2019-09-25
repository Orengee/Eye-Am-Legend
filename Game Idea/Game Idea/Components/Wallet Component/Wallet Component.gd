extends Node2D

export(int) var maximum_value = 9999
export(int) var value = 0


signal value_raised
signal value_lowered
signal value_changed


func raise_value(new_value):
	
	var sum = value + new_value
	
	if(sum > maximum_value):
		value = maximum_value
	else:
		value = sum
	
	emit_signal("value_raised", sum)
	emit_signal("value_changed", value)
	
	pass



func lower_value(new_value):
	
	var difference = value - new_value
	
	if(difference <= 0):
		value = 0
		
	else:
		value = difference
	
	emit_signal("value_lowered", difference)
	emit_signal("value_changed", value)
	
	
	pass
