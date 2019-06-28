extends Node

class_name GDWeaponsAutoAttack

func _ready():
	call_deferred("begin_auto_attack")
	connect("tree_exited",self,"end_auto_attack")

	start_auto_attack()

func start_auto_attack():
	if not $Info.weapon.is_connected("end_action",$Info.weapon,"start_action"):
		$Info.weapon.connect("end_action",$Info.weapon,"start_action")

	if $Info._magazine != null and not $Info._magazine.is_connected("reloaded_successfully",$Info.weapon,"start_action"):
		$Info._magazine.connect("reloaded_successfully",$Info.weapon,"start_action")

	$Info.weapon.start_action()

func end_auto_attack():
	if $Info.weapon.is_connected("end_action",$Info.weapon,"start_action"):
		$Info.weapon.disconnect("end_action",$Info.weapon,"start_action")

	if $Info._magazine != null and $Info._magazine.is_connected("reloaded_successfully",$Info.weapon,"start_action"):
		$Info._magazine.disconnect("reloaded_successfully",$Info.weapon,"start_action")

