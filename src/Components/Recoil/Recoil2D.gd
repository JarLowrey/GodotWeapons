extends Node

export var max_recoil = 15.0

func _ready():
	._ready()
	weapon.connect("ended",self,"_apply_recoil")

func _apply_recoil():
	if view_node is Node2D:
		view_node.global_rotation += max_recoil * random() * ()