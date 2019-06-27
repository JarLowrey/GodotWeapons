extends ActionWithCooldown

signal emptied
signal decremented

export var size = 1
export var auto_reload = false
var _attacks_left_in_mag = 1

func _ready():
	_attacks_left_in_mag = size
	weapon.connect("action_ended",self,"_decrement")

func _decrement():
	if _attacks_left_in_mag > 0:
		_attacks_left_in_mag --
		emit_signal("decremented",_attacks_left_in_mag)
		if _attacks_left_in_mag == 0:
			emit_signal("emptied")
			if auto_reload:
				start_reload()

#wrap parent functions for better names and extra get/set logic
func start_reload():
	#if user reloads during attack cooldown, stop attack cooldown
	_weapon.end_action() 
	.start_action()

func end_reload():
	_attacks_left_in_mag = size
	.end_action()
	
func cancel_reload():
	.cancel_action()