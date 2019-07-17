extends Node

class_name GDWeaponsBulletSpawner

onready var weapon = get_node(GDWeaponsWeapon.WEAPON_PATH_FROM_COMPONENT)

export var bullet_scene_path = "res://test/bullets/SimpleBullet.tscn"

#MUST CONNECT spawn METHOD TO START/END ATTACK IN EDITOR!

func spawn():
	#create bullet
	var b = load(bullet_scene_path).instance()
	get_tree().get_root().add_child(b)

	#initialize bullet
	if weapon is Node2D:
		b.global_rotation = weapon.global_rotation
		b.global_position = weapon.global_position
	else: 
		pass