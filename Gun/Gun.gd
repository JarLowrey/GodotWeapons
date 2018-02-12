extends Node

export var can_fire = true setget set_can_fire

export var auto_fire = true
export var auto_reload = true
export var ammo = -1
export var clip_size = 1

var _clip_ammo_remaining = 1

signal volley_fired
signal out_of_ammo
signal clip_empty
signal can_fire_again

func set_can_fire(val):
	can_fire = val
	if val:
		emit_signal("can_fire_again") 
		if auto_fire and is_inside_tree(): # $MuzzleContainer not loaded if called before _ready because of this exported vars default value
			fire()

func reload():
	_clip_ammo_remaining = clip_size
	can_fire = false
	$ReloadDelayTimer.start()

func _ready():
	_clip_ammo_remaining = clip_size
	
	$ShotDelayTimer.connect("timeout", self, "set_can_fire",[true])
	$ReloadDelayTimer.connect("timeout", self, "set_can_fire",[true])
	
	if auto_fire:
		call_deferred("fire")

func fire():
	if(!can_fire):
		$ShotDelayTimer.start()
		return 
	
	#fire bullets
	var bullets = []
	for muzzle in $MuzzleContainer.get_children():
		var bullet = muzzle.bullet_scene.instance()
		muzzle.get_node("BulletContainer").add_child(bullet)
		bullet.init_inst()
	emit_signal("volley_fired", bullets)
	
	#update ammo/clip
	set_can_fire(false)
	if _clip_ammo_remaining > 0:
		_clip_ammo_remaining -= 1
	if ammo > 0:
		ammo -= 1
	
	#prepare to fire again	
	if ammo==0:
		emit_signal("out_of_ammo")
	else:
		if _clip_ammo_remaining == 0:
			emit_signal("clip_empty")
			if auto_reload:
				reload()
		else:
			$ShotDelayTimer.start()
