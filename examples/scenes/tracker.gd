extends Node2D

func _ready():
	get_node("Gun").connect("volley_fired",self,"set_targets")
	set_process(true)
	pass

func set_targets(bullets):
	for bullet in bullets:
		bullet.set_target(get_node("../enemy"))
