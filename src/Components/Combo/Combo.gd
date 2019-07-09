extends Node

class_name GDWeaponsCombo

signal max_attack_in_combo()
signal too_much_time_btw_attacks_for_combo()
signal combo_incremented()

onready var weapon = get_node(GDWeaponsWeapon.WEAPON_PATH_FROM_COMPONENT)
onready var reset_combo_timer = get_node("Timer")

export var combo_json = ""

var combo_data = [
	{"wait": 0.2},
	{"wait": 0.1},
	{}
]

var current_combo_attack = 0

func _ready():
	weapon.connect("began",self,"increment_combo")
	reset_combo_timer.connect("timeout",self,"combo_timed_out")
	if combo_json != "":
		pass #load JSON
	
func increment_combo():
	var combo = combo_data[current_combo_attack]
	
	apply_combo_data(combo)
	
	if can_increment():
		current_combo_attack += 1
		emit_signal("combo_incremented")
	else:
		emit_signal("max_attack_in_combo")
		reset_combo()
	
	print(current_combo_attack)

func can_increment():
	return current_combo_attack < combo_data.size()

func apply_combo_data(combo):
	if 'wait' in combo:
		reset_combo_timer.wait_time = combo['wait']
	
func reset_combo():
	current_combo_attack = 0
	reset_combo_timer.stop()
	
func combo_timed_out():
	reset_combo()
	emit_signal("too_much_time_btw_attacks_for_combo")