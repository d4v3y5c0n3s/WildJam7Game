extends Position3D

#  implement a fsm for character behviour

var state = 0

###

func _process(delta):
	
	match state:
		0:#  wander state
			pass
		1:#  jealous state
			pass
		2:#  angered state
			pass
		3:#  fearful state
			pass
		4:#  hostile state
			pass
		5:#  thrilled state
			pass
		6:#  dead state
			pass

func _ready():
	pass