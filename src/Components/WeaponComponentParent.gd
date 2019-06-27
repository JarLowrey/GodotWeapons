extends Node

export var weapon_path = ".."
var weapon

export var view_node_path = ""
var _view_node

var mag_path = "Magazine"
var _magazine

func _ready():
	weapon = get_node(weapon_path)
	
	if weapon.has_node(mag_path):
        _magazine = weapon.get_node(mag_path)
    
    if(has_node(view_node_path)):
        _view_node = get_node(view_node_path)