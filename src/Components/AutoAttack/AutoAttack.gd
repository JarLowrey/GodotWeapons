extends Node

class_name GDWeaponsAutoAttack

onready var weapon = get_node(GDWeaponsWeapon.WEAPON_PATH_FROM_COMPONENT)

func _ready():
	call_deferred("start_auto_attack")
	connect("tree_exited",self,"end_auto_attack")

func start_auto_attack():
	if not weapon.is_connected("can_act_again",weapon,"start_action"):
		weapon.connect("can_act_again",weapon,"start_action")

	weapon.start_attack()

func end_auto_attack():
	if weapon.is_connected("can_act_again",weapon,"start_action"):
		weapon.disconnect("can_act_again",weapon,"start_action")
