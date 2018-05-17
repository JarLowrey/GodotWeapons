extends 'res://src/EntityComponents/EnergyUser.gd'

export var can_fire = true setget set_can_fire

#export(PackedScene) var bullet_scene = null

export var auto_fire = true setget set_auto_fire
export var auto_reload = true
export var ammo = -1
export var clip_size = -1 setget set_clip_size

var _clip_ammo_remaining = 1
#var _bullet_pool = []

signal fired
signal out_of_ammo
signal clip_empty
signal can_fire_again

func set_clip_size(val):
	clip_size = val
	_clip_ammo_remaining = clip_size
func set_can_fire(val):
	can_fire = val
	if can_fire:
		emit_signal("can_fire_again") 
		if auto_fire and is_inside_tree():
			fire()

func set_auto_fire(val):
	auto_fire = val
	if auto_fire and can_fire and is_inside_tree(): #if cant fire right now, will fire when timer finishes and can_fire is set to true
		fire()

func reload():
	set_can_fire(false)
	_clip_ammo_remaining = clip_size
	$ReloadDelayTimer.start()
	$ShotDelayTimer.stop()

func _ready():
	$ShotDelayTimer.connect("timeout", self, "set_can_fire",[true])
	$ReloadDelayTimer.connect("timeout", self, "set_can_fire",[true])
	
	if auto_fire:
		call_deferred("fire")

func _add_bullet_to_scene_tree(bullet):
	#add bullet to scene
	var bullet_container = $BulletsLocal 
	if not bullet.use_local_coordinates:
		#use a separate container to keep the remote inspector pretty
		#BulletsWorld cannot be a child of Gun, or else all bullets will be deleted along with Gun
		var name = "BulletsContainerWorld"
		if get_node("/root").has_node(name):
			bullet_container = get_node("/root/" + name)
		else:
			bullet_container = Node.new() #add the container if it doesn't exist
			bullet_container.name = name
			get_node("/root").add_child(bullet_container)
	bullet_container.add_child(bullet)

func fire():
	#fire bullets
	var bullets = get_bullets() #needs to be implemented in a child script
	
	if typeof(bullets) != TYPE_ARRAY:
		bullets = [bullets]
#	# remove bullets from pool
#	var bullet
#	if _bullet_pool.size() == 0:
#		bullet = bullet_scene.instance()
#	else:
#		print("AS")
#		bullet = _bullet_pool.pop_front()
	
	#init bullet props
	for bullet in bullets:
		if "my_gun" in bullet:
			bullet.my_gun = self
		if "my_muzzle" in bullet:
			bullet.my_muzzle = $Muzzle
		if bullet.has_method("fired"):
			bullet.fired()
	emit_signal("fired",bullets)
	
	#update ammo/clip
	set_can_fire(false)
	if _clip_ammo_remaining > 0:
		_clip_ammo_remaining -= 1
	if ammo > 0:
		ammo -= 1
	
	#prepare to fire again
	if ammo==0:
		emit_signal("out_of_ammo")
		$ShotDelayTimer.stop()
	else:
		if _clip_ammo_remaining == 0:
			emit_signal("clip_empty")
			if auto_reload:
				reload()
		else:
			$ShotDelayTimer.start()
	
	return bullets

#func add_to_bullet_pool(bullet):
#	_bullet_pool.append(bullet)