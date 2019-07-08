extends Node

class_name GDWeaponsLongAction  
 
signal began()
signal ended()
signal cancelled()
signal premature_start_attempt()
signal can_act_again()

var is_acting = false
var interupting_actions = []

func add_interupting_action(long_action):
	interupting_actions.append(long_action)
	long_action.connect("ended", self, "_check_can_act")

func remove_interupting_action(long_action):
	long_action.disconnect("ended", self, "_check_can_act")
	var index = interupting_actions.find(long_action)
	interupting_actions.remove(index)

func _check_can_act():
	if can_start_action():
		emit_signal("can_act_again")

func _ready():
	add_interupting_action(self)

func can_start_action():
	for var action in interupting_actions:
		if action.is_acting:
			return false
	return true

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
	# TODO:  clear interupting actions? these likely only need to be done once as setup so may not be necessary