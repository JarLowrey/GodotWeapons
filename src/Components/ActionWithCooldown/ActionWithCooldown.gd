extends WeaponComponentParent

export var delay = 1.0 setget _set_delay
signal can_act_again
signal action_began
signal action_ended

var is_in_cooldown = false
var is_acting = false
var cooldown_timer

var components_moding_can_attack

func _ready():
	cooldown_timer = $Timer
	cooldown_timer.connect("timeout",self, "exit_cooldown")

func can_act():
	return not is_acting and not is_in_cooldown

func start_action():
	if(!can_act()):
		return
	
	is_acting = true
	emit_signal("action_began")
	
func end_action():
	if(is_acting):
		return
	
	is_acting = false
	is_in_cooldown = true

	cooldown_timer.start()
	emit_signal("action_ended")

func exit_cooldown():
	is_in_cooldown = false
	cooldown_timer.stop()
	emit_signal("can_act_again")

func reset():
	is_in_cooldown = false
	is_acting = false;
	cooldown_timer.stop()

func _set_delay(value):
	self.delay = value

	if(is_inside_tree()):
		cooldown_timer.wait_time = delay