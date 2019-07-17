extends Node

class_name GDWeaponsBoolBlocker

export var input_action_trigger = "" setget _set_input_trigger
export var auto_reset = false

func flip():
	pass #implement in children

func _process(delta):
	if Input.is_action_just_pressed(input_action_trigger):
		flip()

func _set_input_trigger(val):
	input_action_trigger = val
	set_process(input_action_trigger != "") #optimization! may need to remove if adding stuff in process beyond input checking