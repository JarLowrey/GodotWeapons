extends Node

export var wielder_path = ".."
var _wielder

func _ready():
    _wielder = get_node(wielder_path)

func wielder_revived():
    set_physics_process(true)
    set_process(true)

func wielder_killed():
    set_physics_process(false)
    set_process(false)
    $ActionWithCooldown.reset()