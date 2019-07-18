extends Node

class_name GDWeaponsMagazine

export var auto_reload = true setget set_auto_reload

onready var weapon = get_node(GDWeaponsWeapon.WEAPON_PATH_FROM_COMPONENT)

func _ready():
	weapon.add_action_to_interupt_start($ReloadAction)
	weapon.add_action_to_interupt_start($MagCapacity)
	weapon.connect("ended",$MagCapacity,"decrement")
	set_auto_reload(auto_reload)

func set_auto_reload(val):
	auto_reload = val
	var was_auto_cnt = $MagCapacity.is_connected("emptied",$ReloadAction,"start_action")
	if auto_reload and not was_auto_cnt:
		$MagCapacity.connect("emptied",$ReloadAction,"start_action")
	elif not auto_reload and was_auto_cnt:
		$MagCapacity.disconnect("emptied",$ReloadAction,"start_action")
