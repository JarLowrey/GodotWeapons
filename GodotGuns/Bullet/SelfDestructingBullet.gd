extends "./KillableBullet.gd"

#Must have node $SelfDestructTimer of type Timer

export var kill_after_time = -1.0 setget set_kill_after_time

func fired(gun):
	.fired(gun)
	set_kill_after_time(kill_after_time)

func set_kill_after_time(val):
	kill_after_time = val
	if kill_after_time > 0 and is_inside_tree():
		if $SelfDestructTimer.is_connected("timeout",self,"kill"):
			$SelfDestructTimer.disconnect("timeout",self,"kill")
			$SelfDestructTimer.stop()
		else:
			$SelfDestructTimer.connect("timeout",self,"kill")
		
		if val > 0:
			$SelfDestructTimer.wait_time = val
			$SelfDestructTimer.start()
