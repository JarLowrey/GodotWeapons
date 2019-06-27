extends WeaponComponentParent

signal emptied
signal decremented

export var max_amount = 1
var current_amount = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	current_amount = max_amount
	weapon.connect("action_began",this,"decrement")

func decrement():
	if current_amount > 0:
		current_amount -= 1
		emit_signal("decremented")
		if current_amount == 0:
			emit_signal("emptied")