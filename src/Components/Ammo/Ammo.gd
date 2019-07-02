extends Node

class_name GDWeaponsAmmo

onready var weapon = get_node(GDWeaponsWeapon.WEAPON_PATH_FROM_COMPONENT)

signal emptied()
signal decremented(amt_left)

export var max_amount = 1
var current_amount = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	current_amount = max_amount
	weapon.connect("action_began",self,"decrement")

func decrement():
	if current_amount > 0:
		current_amount -= 1
		emit_signal("decremented",current_amount)
		if current_amount == 0:
			emit_signal("emptied") 