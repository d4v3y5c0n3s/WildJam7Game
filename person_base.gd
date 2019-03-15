extends Position3D

var state = 0
var speed = 4.0

###

func _process(delta):
	
	var current_action = 0
	var completed_action = true
	
	match state:
		0:#  wander state
			if completed_action:#  if there is no current action, randomly choose one
				current_action = randi() % 3 + 1#  chooses a random action
			else:
				match current_action:
					1:
						pass
					2:
						pass
					3:
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