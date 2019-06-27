extends "../WeaponComponentParent.gd"

var current_attack_in_burst = 0
export var attacks_in_burst = 1
export var burst_delay = 1.0
export var post_burst_delay = 1.0

func _ready():
	weapon.connect("action_ended",self,"set_delay")
	if _magazine != null:
		_magazine.connect("reloaded_successfully",self,"reset_current_attack_in_burst")

func _set_weapon_delay():
	current_attack_in_burst ++
	
	weapon.cooldown_delay = (current_attack_in_burst < attacks_in_burst) ? burst_delay : post_burst_delay
	
	if current_attack_in_burst == attacks_in_burst:
		current_attack_in_burst = 0

func reset_current_attack_in_burst():
	current_attack_in_burst = 0