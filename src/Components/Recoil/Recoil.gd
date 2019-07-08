extends Node

class_name GDWeaponsRecoil

export var max_recoil = 5.0

onready var weapon = get_node(GDWeaponsWeapon.WEAPON_PATH_FROM_COMPONENT)

func _ready():
	._ready()
	weapon.connect("ended",self,"_apply_recoil")

func _apply_recoil():
	if weapon is Node2D: 
		weapon.global_rotation += max_recoil * (2 * randf() - 1)
	else:
		pass