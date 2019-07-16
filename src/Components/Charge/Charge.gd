extends GDWeaponsLongAction

class_name GDWeaponsCharge

onready var weapon = get_node(GDWeaponsWeapon.WEAPON_PATH_FROM_COMPONENT)
export var wait_at_max_charge_until_cancel = -1 setget _set_wait

func _ready():
	actions_interupt_start = weapon.actions_interupt_start.duplicate()
	weapon.add_action_to_interupt_start(self)
	
	$MaxChargeHoldTimer.connect("timeout",weapon,"cancel_attack")
	$MaxChargeHoldTimer.connect("timeout",self,"cancel_action")
	_set_wait(wait_at_max_charge_until_cancel)

func end_action():
	$Capacity.current_capacity = 0
	.end_action()
	weapon.start_attack()

func can_start_action():
	return .can_start_action() and $Capacity.current_capacity == 0

func _set_wait(val):
	wait_at_max_charge_until_cancel = val
	if(val > 0):
		$MaxChargeHoldTimer.wait_time = wait_at_max_charge_until_cancel
	
	var timer_on_fill_connected = $Capacity.is_connected("filled",$MaxChargeHoldTimer,"start")
	if val <= 0:
		$MaxChargeHoldTimer.stop()
		if timer_on_fill_connected:
			$Capacity.disconnect("filled",$MaxChargeHoldTimer,"start")
	elif val > 0 and not timer_on_fill_connected:
		$Capacity.connect("filled",$MaxChargeHoldTimer,"start")
