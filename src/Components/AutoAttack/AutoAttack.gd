extends Node

class_name GDWeaponsAutoAttack

onready var weapon = get_node(GDWeaponsWeapon.WEAPON_PATH_FROM_COMPONENT)

func _ready():
	call_deferred("start_auto_attack")
	connect("tree_exited",self,"end_auto_attack")

func start_auto_attack():
	_connect_weapon(true)
	_connect_charge(true)
	_connect_mag(true)
	
	start_attacking()

func end_auto_attack():
	_connect_weapon(false)
	_connect_charge(false)
	_connect_mag(false)

func start_attacking():
	if weapon.charge != null:
		weapon.charge.start_action()
	else:
		weapon.start_attack()
		
func _connect_mag(to_connect):
	if weapon.magazine != null:
		var action = weapon.magazine.get_node("ReloadAction")
		var cntd = action.is_connected("ended",weapon,"start_attack")
		if to_connect and not cntd:
			action.connect("ended",weapon,"start_attack")
		elif not to_connect and cntd:
			action.disconnect("ended",weapon,"start_attack")

func _connect_charge(to_connect):
	if weapon.charge != null:
		var cap = weapon.charge.get_node("Capacity")
		var cap_connected = cap.is_connected("filled",weapon.charge,"end_attack")
		if to_connect and not cap_connected:
			cap.connect("filled",weapon.charge,"end_attack")
		elif not to_connect and cap_connected:
			cap.disconnect("filled",weapon.charge,"end_attack")

func _connect_weapon(to_connect):
	var weapon_connected = weapon.is_connected("can_start_action_again",weapon,"start_attack")
	if to_connect and not weapon_connected:
		weapon.connect("can_start_action_again",weapon,"start_attack")
	elif not to_connect and weapon_connected:
		weapon.disconnect("can_start_action_again",weapon,"start_attack")