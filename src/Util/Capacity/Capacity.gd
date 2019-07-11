extends Node

class_name GDWeaponsCapacity

signal emptied()
signal filled()
signal decremented(val)
signal incremented(val)

export var max_capacity = 1
export var step = 1.0
export var recharge_freq = 0.0 setget set_recharge_freq
var current_capacity = 0 setget set_curr_capacity

func _ready():
	set_recharge_freq(recharge_freq)
	
func decrement():
	if current_capacity > 0:
		set_curr_capacity(current_capacity - step)
		emit_signal("decremented",current_capacity)

func increment():
	if current_capacity < max_capacity:
		set_curr_capacity(current_capacity + step)
		emit_signal("incremented",current_capacity)

func set_curr_capacity(new_val):
	var prev_value = current_capacity
	current_capacity = clamp(new_val,0,max_capacity)
	
	if new_val == 0 and prev_value != 0:
		emit_signal("emptied") 
	if new_val == max_capacity and prev_value != max_capacity:
		emit_signal("filled") 

func set_recharge_freq(val):
	if not has_node("Timer"):
		var timer = Timer.new()
		timer.name = "Timer"
		add_child(timer)
		timer.connect("timeout",self,"increment")
	
	recharge_freq = val
	$Timer.wait_time = recharge_freq
	$Timer.start()