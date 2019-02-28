extends Node


func spawn_bullets(): #needs to be implemented in a child script
	pass

export var auto_fire = true setget set_auto_fire
export var auto_reload_clip = true
export var clip_size = 1 setget set_clip_size
export var ammo = -1

var _in_clip = 1

signal out_of_ammo
signal start_reload_clip_cooldown
signal start_shot_cooldown
signal clip_empty
signal fired

func set_clip_size(val):
	clip_size = val
	_in_clip = clip_size

func can_fire():
	return not is_reloading_clip() and not is_in_shot_cooldown() and _in_clip != 0 and ammo != 0

func set_auto_fire(val):
	auto_fire = val
	
	if auto_fire:
		$ShotDelayTimer.connect("timeout", self, "fire")
		$ReloadDelayTimer.connect("timeout", self, "fire")
		if can_fire() and is_inside_tree():
			fire()
	else:
		$ShotDelayTimer.disconnect("timeout", self, "fire")
		$ReloadDelayTimer.disconnect("timeout", self, "fire")

func is_reloading_clip():
	return not $ReloadDelayTimer.is_stopped() # time_left > 0

func is_in_shot_cooldown():
	return not $ShotDelayTimer.is_stopped() # time_left > 0

func reload_clip():
	print("reloading")
	
	print(is_reloading_clip())
	if not is_reloading_clip():
		emit_signal("start_reload_clip_cooldown", $ReloadDelayTimer.wait_time)
		_in_clip = clip_size
		$ReloadDelayTimer.start()
		$ShotDelayTimer.stop()

func _ready():
	set_auto_fire(auto_fire) #initialize attached nodes
	_in_clip = clip_size
	if auto_fire:
		fire()

func fire():
	var bullets = []
		
	if can_fire():
		#fire bullets
		bullets = spawn_bullets()
		emit_signal("fired", bullets)
		
		#update ammo/clip
		if _in_clip > 0:
			_in_clip -= 1
		if ammo > 0:
			ammo -= 1
		
		$ShotDelayTimer.start()
		emit_signal("start_shot_cooldown", $ShotDelayTimer.wait_time)
	
		#prepare to fire again
		if ammo==0:
			emit_signal("out_of_ammo")
		else:
			if _in_clip == 0:
				emit_signal("clip_empty")
				if auto_reload_clip:
					reload_clip()
		
	return bullets
