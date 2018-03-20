extends Node

#onready var my_muzzle = get_node("../..")
#onready var my_gun = get_node("../../../..")
var my_gun
var my_muzzle
var make_child_of_root = true #false = bullet is eventual descendent of gun in scene tree. Will move with gun, be deleted with gun, etc

#death/kill/free() related vars
export var kill_after_time = false setget set_kill_after_time
export var kill_on_exit = true setget set_kill_on_viewport_exit
export var kill_after_travel_dist = -1

var traveled_dist = 0 #must be updated in 2d/3d children physics_process
var _is_killed = false

signal bullet_killed

func _ready():
	set_kill_on_viewport_exit(kill_on_exit) #setting from editor will not connect signal since node is not loaded
	set_kill_after_time(kill_after_time) #setting from editor will not connect signal since node is not loaded

func _physics_process(delta):
	if kill_after_travel_dist > 0 and traveled_dist >= kill_after_travel_dist:
		kill()

func set_kill_on_viewport_exit(val):
	kill_on_exit = val
	if is_inside_tree():
		var is_cntd = $VisibilityNotifier.is_connected("screen_exited",self,"queue_free")
		if val:
			if not is_cntd:
				$VisibilityNotifier.connect("screen_exited",self,"queue_free")
		elif is_cntd:
			$VisibilityNotifier.disconnect("screen_exited",self,"queue_free")

func set_kill_after_time(val):
	kill_after_time = val
	if is_inside_tree():
		var is_cntd = $SelfDestructTimer.is_connected("timeout",self,"kill")
		if val:
			if not is_cntd:
				$SelfDestructTimer.connect("timeout",self,"kill")
				$SelfDestructTimer.start()
		elif is_cntd:
			$SelfDestructTimer.disconnect("timeout",self,"kill")
			$SelfDestructTimer.stop()

func kill(arg=null):
	emit_signal("bullet_killed",self)
	
	#ensure object is not killed more than once
	set_kill_after_time(false)
	set_kill_on_viewport_exit(false)
	kill_after_travel_dist = -1
	
	queue_free()