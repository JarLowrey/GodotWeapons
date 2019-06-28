extends Node

class_name GDWeaponsBulletSpawner

export var bullet_scene_path = ""

#MUST CONNECT spawn METHOD TO START/END ATTACK IN EDITOR!

func spawn():
	#create bullet 
	var b = load(bullet_scene_path).instance()
	get_tree().get_root().add_child(b)

	#initialize bullet
	if $Info._view_node is Node2D and b is Node2D:
		b.global_rotation = $Info._view_node.global_rotation
		b.global_position = $Info._view_node.global_position
	#else: #is 3D