extends ActionWithCooldown

export var wielder_path = ".."
var _wielder

signal can_attack_again
var components_moding_can_attack = []

func _ready():
    weapon = self
    _wielder = get_node(wielder_path)

func can_act():
    var capable_of_acting = base.can_act()
    for (var comp in components_moding_can_attack):
        capable_of_acting = capable_of_acting && comp.can_act()
    return capable_of_acting

func wielder_revived():
    set_physics_process(true)
    set_process(true)

func wielder_killed():
    set_physics_process(false)
    set_process(false)
    $ActionWithCooldown.reset()