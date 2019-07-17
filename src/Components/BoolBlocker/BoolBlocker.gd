extends Node

class_name GDWeaponsBoolBlocker

export var input_action_trigger = ""
export var auto_reset = false

func _ready():
	pass

func _input(event):
	if event == input_action_trigger:
		
