extends Node

class_name GDWeaponsCombo

signal max_attack_in_combo()
signal too_much_time_btw_attacks_for_combo()
signal combo_incremented()

onready var weapon = get_node(GDWeaponsWeapon.WEAPON_PATH_FROM_COMPONENT)
onready var reset_combo_timer = get_node("Timer")

#overwrite this with your own data, and apply it in apply_combo_data
var combo_data = [
	{"wait": 2},
	{"wait": 1.5},
	{}
]

var current_combo_attack = 0

func apply_combo_data(combo): # IMPLEMENT ME
	if 'wait' in combo:
		reset_combo_timer.wait_time = combo['wait']



func _ready():
	weapon.connect("began",self,"increment_combo")
	reset_combo_timer.connect("timeout",self,"combo_timed_out")
	
func increment_combo():
	var combo = combo_data[current_combo_attack]
	print("current step in combo: ")
	print(current_combo_attack)
	apply_combo_data(combo)
	reset_combo_timer.start()
	
	if can_increment():
		current_combo_attack += 1
		emit_signal("combo_incremented")
	else:
		emit_signal("max_attack_in_combo")
		reset_combo()

func can_increment():
	return current_combo_attack < combo_data.size() - 1
	
func reset_combo():
	current_combo_attack = 0
	reset_combo_timer.stop()
	
func combo_timed_out():
	reset_combo()
	emit_signal("too_much_time_btw_attacks_for_combo")