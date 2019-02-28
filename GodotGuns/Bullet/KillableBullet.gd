extends "./Bullet.gd"

var _is_killed

signal bullet_killed

func fired(gun):
	.fired(gun)
	_is_killed = false

func kill(arg=null):
	if not _is_killed: #can only die once
		emit_signal("bullet_killed", self)
	
	_is_killed = true
