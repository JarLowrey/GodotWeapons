extends "res://GodotGuns/Gun/Gun.gd"

func spawn_bullets():
	print(_in_clip)
	var b_scene = preload("res://GodotGunsTest/src/scenes/Bullet2D.tscn")
	var b = b_scene.instance()
	b.init(self)
	
	get_tree().get_root().call_deferred("add_child",b)
	
	b.position = self.position
	
	return [b]

func fire():
	print("fired")
	return .fire()