extends Node

class_name GDWeaponsAutoAttack

onready var weapon = get_node(GDWeaponsWeapon.WEAPON_PATH_FROM_COMPONENT)

func _ready():
	call_deferred("start_auto_attack")
	connect("tree_exited",self,"end_auto_attack")

func start_auto_attack():
	if not weapon.is_connected("cooldown_over",weapon,"start_action"):
		weapon.connect("cooldown_over",weapon,"start_action")

	if weapon.magazine != null and not weapon.magazine.is_connected("ended",weapon,"start_action"):
		weapon.magazine.connect("ended",weapon,"start_action")
	weapon.start_action()

func end_auto_attack():
	if weapon.is_connected("ended",weapon,"start_action"):
		weapon.disconnect("ended",weapon,"start_action")

	if weapon.magazine != null and weapon.magazine.is_connected("ended",weapon,"start_action"):
		weapon.magazine.disconnect("ended",weapon,"start_action")
