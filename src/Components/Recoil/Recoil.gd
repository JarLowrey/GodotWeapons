extends Node

class_name GDWeaponsRecoil

export var max_recoil = 15.0

func _ready():
	._ready()
	$Info.weapon.connect("ended",self,"_apply_recoil")

func _apply_recoil():
	if $Info._view_node is Node2D:
		$Info._view_node.global_rotation += max_recoil * (2 * randf() - 1)