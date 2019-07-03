extends Node

class_name GDWeaponsLongAction  
 
signal began()
signal ended()
signal cancelled()
signal premature_start_attempt()

var is_acting = false

func _ready():
	pass

func can_start_action():
	return not is_acting

func start_action():
	if(!can_start_action()):
		emit_signal("premature_start_attempt")
		return
	_apply_start_action()

func end_action():
	if(!is_acting):
		return
	_apply_end_action()

func cancel_action():
	if(!is_acting):
		return
	_apply_cancel_action()

func _apply_cancel_action():
	is_acting = false
	emit_signal("cancelled")
	
func _apply_end_action():
	is_acting = false
	emit_signal("ended")
	
func _apply_start_action():
	is_acting = true
	emit_signal("began")

func reset():
	is_acting = false;