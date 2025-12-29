extends Node

class_name GDWeaponsCapacity

signal emptied
signal filled

signal overload_attempted
signal underload_attempted
signal change_attempted_but_was_unneeded

signal current_capacity_increased
signal current_capacity_decreased

signal max_capacity_changed

signal can_decrement_again

@export var decrement_step = 1
@export var increment_step = 1

@export var max_capacity:int:
	get:
		return max_capacity
	set(value):
		var prev = max_capacity
		max_capacity = max(value,0)
		if(max_capacity!=prev): max_capacity_changed.emit()

var current_capacity : float = max_capacity :
	set = _curr_cap_changed

func has_capacity_to_decrement():
	return current_capacity>= decrement_step
func is_full():
	return current_capacity == max_capacity
func is_empty():
	return current_capacity == 0
func reset(amt):
	max_capacity = amt
	refill()
func refill():
	current_capacity = max_capacity
func decrement():
	current_capacity-=decrement_step
func increment():
	current_capacity+=increment_step
func empty():
	current_capacity = 0

func _curr_cap_changed(value):
	if value > max_capacity: overload_attempted.emit()
	elif value < 0: underload_attempted.emit()
		
	var prev = current_capacity
	current_capacity = clamp(0,value,max_capacity)

	var has_lowered = prev > current_capacity
	var has_raised = prev < current_capacity
	var stayed = prev == current_capacity
		
	
	if(has_lowered):
		current_capacity_decreased.emit()
		if current_capacity == 0: emptied.emit()
	elif (has_raised):
		current_capacity_increased.emit()
		if is_full(): filled.emit()
		if prev < decrement_step and current_capacity >= decrement_step: can_decrement_again.emit()
	elif (stayed):
		change_attempted_but_was_unneeded.emit()
