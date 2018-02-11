extends Node

onready var my_gun = get_node("../..")

#death/kill/free() related vars
export var kill_after_travel_dist = -1
export var kill_after_time = false
export var kill_on_exit = false setget set_kill_on_viewport_exit

#private vars
var _traveled_dist = 0
onready var _prev_pos = self.global_position

signal bullet_killed

func _on_ready():
	if kill_after_time:
		$SelfDestructTimer.autostart = true
		$SelfDestructTimer.connect("timeout",self,"kill")

func set_kill_on_viewport_exit(val):
	kill_on_exit = val
	if $VisibilityNotifier:
		if kill_on_exit:
			$VisibilityNotifier.connect("screen_exited",self,"kill")
		else:
			$VisibilityNotifier.disconnect("screen_exited",self,"kill")

func _physics_process(delta):
	#increment travel distance if that is a death param
	if kill_after_travel_dist > 0:
		_traveled_dist += get_global_pos().distance_to(_prev_pos)
		if(_traveled_dist >= kill_after_travel_dist):
			kill()
		else:
			_prev_pos = get_global_pos()

func kill(arg=null):
	emit_signal("bullet_killed",self)
	queue_free()