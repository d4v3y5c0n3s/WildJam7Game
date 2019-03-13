extends Position3D

#  implement a fsm for character behviour

#  potential states:
#
# -begrudgingly pleasant
# -neutral
# -hostile
# -stalking
# -alarmed
# -paranoid
# -deceptively calm ()
# -thrilled (when character gets inhertance)
# -

class StateMachine:
	var handlers = {}
	var startState = null
	var endStates = []
	
	func add_state(name, handler, end_state=0):
		pass

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass