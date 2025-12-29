extends Node

class_name GDWeaponsLongAction  
 
signal began()
signal ended()
signal canceled()
signal premature_start_attempt()
signal can_start_action_again()
signal can_end_action()

#@export auto_acts = false set=_auto_acts_changed

var is_acting = false
var blockers = []

func _ready():
	pass

func add_blocker(blk):
	assert(validate_is_blocker(blk), "Invalid action blocker")
	blockers.append(blk)

func _check_can_start():
	if can_start_action():
		can_start_action_again.emit()

func _check_can_end():
	if can_end_action_check():
		can_end_action.emit()

func can_end_action_check():
	var can_end = is_acting
	for b in blockers:
		var tries_block = b.get("block_on_end") != null and b.block_on_end
		can_end = can_end and not (tries_block and b.is_blocked())
	return can_end
	
func can_start_action():
	var can_start = not is_acting
	for b in blockers:
		var tries_block = b.get("block_on_start") != null and b.block_on_start
		can_start = can_start and not (tries_block and b.is_blocked())
	return can_start

func start_action():
	print("action started")
	if(!can_start_action()):
		print("cannot start")
		premature_start_attempt.emit()
		return false
	_apply_start_action()
	return true

func end_action():
	print("action ended")
	if(!can_end_action_check()):
		print("cannot end")
		return false
	_apply_end_action()
	return true

func cancel_action():
	if(!is_acting):
		return false
	_apply_cancel_action()
	return true

func _apply_cancel_action():
	is_acting = false
	canceled.emit()
	emit_signal("canceled")
	
func _apply_end_action():
	is_acting = false
	ended.emit()
	
func _apply_start_action():
	is_acting = true
	began.emit()

func reset():
	is_acting = false;
	# TODO:  clear interupting actions? these likely only need to be done once as setup so may not be necessary


# enforce interface
func validate_is_blocker(node):
	var has_trigger_point = node.get("block_on_start") != null or node.get("block_on_end") != null
	return node.has_signal("blocking_ended") and node.has_method("is_blocked") and has_trigger_point

#func _auto_acts_changed(value):
	#auto_acts = value
