extends Node

onready var my_muzzle = get_node("../..")
onready var my_gun = get_node("../../../..")

#death/kill/free() related vars
export var kill_after_time = false
export var kill_on_exit = true setget set_kill_on_viewport_exit
export var kill_after_travel_dist = -1

var traveled_dist = 0 #must be updated in 2d/3d children physics_process

signal bullet_killed

func _on_ready():
	if kill_after_time:
		$SelfDestructTimer.connect("timeout",self,"kill")
		$SelfDestructTimer.start()

func _physics_process(delta):
	if kill_after_travel_dist > 0 and traveled_dist >= kill_after_travel_dist:
		kill()

func set_kill_on_viewport_exit(val):
	kill_on_exit = val
	if is_inside_tree():
		if kill_on_exit:
			$VisibilityNotifier.connect("screen_exited",self,"kill")
		else:
			$VisibilityNotifier.disconnect("screen_exited",self,"kill")

func kill(arg=null):
	emit_signal("bullet_killed",self)
	queue_free()