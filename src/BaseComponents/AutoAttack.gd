extends Node

class_name GDWeaponsAutoAttack

@onready var weapon : GDWeaponsWeapon = get_node(GDWeaponsWeapon.WEAPON_PATH_FROM_COMPONENT)
@onready var magazine : GDWeaponsMagazine = weapon.get_node("Magazine") if weapon.has_node("Magazine") else null

func _ready():
	start_auto_attack.call_deferred()
	tree_exited.connect(end_auto_attack)

func start_auto_attack():
	_connect_weapon(true)
	_connect_mag(true)
	
	weapon.start_attack()

func end_auto_attack():
	_connect_weapon(false)
	_connect_mag(false)

func _connect_mag(to_connect):
	if magazine != null:
		var cntd = magazine.blocking_ended.is_connected(weapon.start_attack)
		if to_connect and not cntd:
			magazine.blocking_ended.connect(weapon.start_attack)
		elif not to_connect and cntd:
			magazine.blocking_ended.disconnect(weapon.start_attack)

func _connect_weapon(to_connect):
	var weapon_connected = weapon.can_start_action_again.is_connected(weapon.start_attack)
	if to_connect and not weapon_connected:
		weapon.can_start_action_again.connect(weapon.start_attack)
	elif not to_connect and weapon_connected:
		weapon.can_start_action_again.disconnect(weapon.start_attack)
