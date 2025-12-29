extends Node

class_name GDWeaponsBulletSpawner

@onready var weapon : GDWeaponsWeapon = get_node(GDWeaponsWeapon.WEAPON_PATH_FROM_COMPONENT)

@export var bullet_scene_path = "res://test/bullets/SimpleBullet.tscn"

func _ready():
	weapon.began.connect(spawn)

func spawn():
	print ("spawn bullet")
	#create bullet
	var b = load(bullet_scene_path).instantiate()
	get_tree().get_root().add_child(b)

	#initialize bullet - TODO customize this for your bullets
	b.global_rotation = weapon.global_rotation
	b.global_position = weapon.global_position
