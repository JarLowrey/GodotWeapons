extends Node2D

func _ready():
	get_node("Gun").connect("volley_fired",self,"set_targets")
	pass

func set_targets(bullets):
	for bullet in bullets:
		bullet.target = get_node("../enemy")