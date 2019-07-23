extends Node

class_name GDWeaponsBurst

var current_attack_in_burst = 0
export var attacks_in_burst = 2 # 2 or more

onready var weapon = get_node(GDWeaponsWeapon.WEAPON_PATH_FROM_COMPONENT)
onready var cooldown = weapon.get_node("FiringCooldown")
onready var ammo = weapon.get_node("Ammo") if weapon.has_node("Ammo") else null
onready var magazine = weapon.get_node("Magazine") if weapon.has_node("Magazine") else null

var _burst_auto = preload("../../BaseComponents/AutoAttack/AutoAttack.tscn").instance()

# IMPLEMENT THESE TWO FUNCTIONS:
func _apply_burst_cooldown():
	# cooldown.get_node("Timer").wait_time = 0.25	
	pass
func _apply_original_cooldown():
	# cooldown.get_node("Timer").wait_time = 2
	pass




func _ready():
	_setup()
	connect("tree_exited",self,"_cleanup")

func _cleanup():
	weapon.disconnect("began",self,"play_burst")
	if ammo != null:
		ammo.disconnect("emptied",self,"_end_burst")
	if magazine != null:
		magazine.get_node("MagCapacity").disconnect("emptied",self,"_end_burst")

	_apply_original_cooldown()

func _setup():
	weapon.connect("began",self,"play_burst")
	if ammo != null:
		ammo.connect("emptied",self,"_end_burst")
	if magazine != null:
		magazine.get_node("MagCapacity").connect("emptied",self,"_end_burst")

	_apply_burst_cooldown()
	current_attack_in_burst = attacks_in_burst - 1

func _start_burst():
	if not weapon.has_node("AutoAttack"):
		weapon.add_child(_burst_auto)
	_apply_burst_cooldown()

func _end_burst():
	if _burst_auto.get_parent() == weapon:
		weapon.remove_child(_burst_auto)
	_apply_original_cooldown()
	current_attack_in_burst = attacks_in_burst

func play_burst():
	if current_attack_in_burst == attacks_in_burst:
		_start_burst()
		current_attack_in_burst -= 1
	elif current_attack_in_burst == 1:
		_end_burst()
	else:
		current_attack_in_burst -= 1
	