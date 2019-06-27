extends "../WeaponComponentParent.gd"

export var bullet_scene_path = ""

#MUST CONNECT spawn METHOD TO START/END ATTACK IN EDITOR!

func spawn():
	#create bullet 
	var b = load(bullet_scene_path).instance()
	get_tree().get_root().add_child(b)

	#initialize bullet
	if _view_node is Node2D and b is Node2D:
		b.global_rotation = _view_node.global_rotation
		b.global_position = _view_node.global_position
	#else: #is 3D