extends ActionWithCooldown

export var wielder_path = ".."
var _wielder

func _ready():
    .weapon = self
    _wielder = get_node(wielder_path)

func can_act():
	var act = .can_act()
	if has_node("Magazine"):
		var m = get_node("Magazine")
		act = act && m.can_act()
	return act