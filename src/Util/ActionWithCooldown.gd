extends GDWeaponsLongAction

class_name GDWeaponsActionWithCooldown 

export var cooldown_delay = 1.0 setget _set_cooldown_delay
onready var original_cooldown_delay = cooldown_delay

signal cooldown_over()

var is_in_cooldown = false
export var timer_path = "Timer"
onready var cooldown_timer = get_node(timer_path)
 
func _ready():
	cooldown_timer.connect("timeout",self, "exit_cooldown")
	_apply_cooldown_delay()

func can_start_action():
	return .can_start_action() and not is_in_cooldown

func _apply_end_action():
	._apply_end_action()
	is_in_cooldown = true
	cooldown_timer.start()

func exit_cooldown():
	print("cooldown ended")
	is_in_cooldown = false
	cooldown_timer.stop() #just in case this is manually called
	emit_signal("cooldown_over")

func reset():
	.reset()
	is_in_cooldown = false
	cooldown_timer.stop()

func _set_cooldown_delay(value):
	cooldown_delay = value
	_apply_cooldown_delay();

func _apply_cooldown_delay():
	if(is_inside_tree()):
		cooldown_timer.wait_time = cooldown_delay