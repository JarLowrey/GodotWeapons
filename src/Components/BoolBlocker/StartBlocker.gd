extends Node

onready var weapon = get_node("..")

export var can_start = false setget _set_can_start

signal ended()

func _ready():
	weapon.add_action_to_interupt_start(self)
	_set_can_start(can_start)

func can_start_action():
	return can_start
	
func _set_can_start(val):
	can_start = val
	emit_signal("ended")