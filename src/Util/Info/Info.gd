extends Node

class_name GDWeaponsInfo

export var weapon_path = "../.."
var weapon

export var view_node_path_from_weapon = ".."
var _view_node

var mag_path_from_weapon = "Magazine"
var _magazine

func _ready():
	weapon = get_node(weapon_path)
	
	if weapon.has_node(mag_path_from_weapon):
		_magazine = weapon.get_node(mag_path_from_weapon)
	
	if(weapon.has_node(view_node_path_from_weapon)):
		_view_node = weapon.get_node(view_node_path_from_weapon)