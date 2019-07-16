extends Node

onready var weapon = get_node("..")

export var can_end = false setget _set_can_end

signal ended()

func _ready():
	weapon.add_action_to_interupt_end(self)
	_set_can_end(can_end)

func can_end_action():
	return can_end
	
func _set_can_end(val):
	can_end = val
	emit_signal("ended")