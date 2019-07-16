extends Node

class_name GDWeaponsCapacity

signal emptied()
signal filled()
signal decremented(val)
signal incremented(val)
signal not_enough_capacity()

export var max_capacity = 1
export var step = 1.0
onready var current_capacity = max_capacity setget set_curr_capacity

func refill():
	current_capacity = max_capacity

func decrement():
	if current_capacity >= step:
		set_curr_capacity(current_capacity - step)
		emit_signal("decremented",current_capacity)

func increment():
	if current_capacity < max_capacity:
		set_curr_capacity(current_capacity + step)
		emit_signal("incremented",current_capacity)

func set_curr_capacity(new_val):
	var prev_value = current_capacity
	var clamped_val = clamp(new_val,0,max_capacity)
	
	var clamped_diff = clamped_val - prev_value
	var actual_diff = new_val - prev_value
	if clamped_diff != actual_diff: #cannot perform this action!
		emit_signal("not_enough_capacity")
	else:
		current_capacity = clamped_val
		if current_capacity == 0 and prev_value != 0:
			emit_signal("emptied") 
		elif current_capacity == max_capacity and prev_value != max_capacity:
			emit_signal("filled")
