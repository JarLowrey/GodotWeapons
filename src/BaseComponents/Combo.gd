extends Node

class_name GDWeaponsCombo

signal combo_reset()
signal combo_incremented(int)

@onready var weapon : GDWeaponsWeapon = get_node(GDWeaponsWeapon.WEAPON_PATH_FROM_COMPONENT)

var combo_count = 0

@export var reset_combo_timer : Timer 

func _ready():
	weapon.began.connect(increment_combo)
	reset_combo_timer.timeout.connect(combo_timed_out)

func increment_combo():
	reset_combo_timer.start() #reset timer for next combo attack
	
	combo_count += 1
	combo_incremented.emit(combo_count)

func combo_timed_out():
	combo_count = 0
	reset_combo_timer.stop()
	combo_reset.emit()
