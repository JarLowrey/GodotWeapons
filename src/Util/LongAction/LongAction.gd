extends Node

class_name GDWeaponsLongAction 

signal began()
signal ended()
signal cancelled()
signal premature_start_attempt()

var is_acting = false

func can_start_action():
	return not is_acting

func start_action():
	if(!can_start_action()):
		emit_signal("premature_start_attempt")
		return
	
	is_acting = true
	emit_signal("began")

func end_action():
	print("ended " + str(is_acting))
	if(!is_acting):
		return
	
	emit_signal("ended")

func cleanup_action():
	is_acting = false

func cancel_action():
	if(!is_acting):
		return
	
	is_acting = false
	emit_signal("cancelled")

func reset():
	is_acting = false;