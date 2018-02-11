extends Node

onready var my_gun = get_node("../..")

#death/kill/free() related vars
export var kill_after_time = false
export var kill_on_exit = false setget set_kill_on_viewport_exit
export var kill_after_travel_dist = -1

var traveled_dist = 0 #must be updated in 2d/3d children physics_process

signal bullet_killed

func init(dir,pos):
	pass

func _on_ready():
	if kill_after_time:
		$SelfDestructTimer.autostart = true
		$SelfDestructTimer.connect("timeout",self,"kill")

func _physics_process(delta):
	if has_method('move'): 
		move()
	
	if kill_after_travel_dist > 0 and traveled_dist >= kill_after_travel_dist:
		kill()

func set_kill_on_viewport_exit(val):
	kill_on_exit = val
	if has_node("VisibilityNotifier"):
		if kill_on_exit:
			$VisibilityNotifier.connect("screen_exited",self,"kill")
		else:
			$VisibilityNotifier.disconnect("screen_exited",self,"kill")

func kill(arg=null):
	emit_signal("bullet_killed",self)
	queue_free()