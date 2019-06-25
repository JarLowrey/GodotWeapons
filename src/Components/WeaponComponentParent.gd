extends Node

export var weapon_path =".."
var weapon

func _ready():
    weapon = get_node(weapon_path)