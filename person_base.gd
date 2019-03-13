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
	var selfHandlers = {}
	var startState = null
	var endStates = []
	
	func add_state(name, handler, end_state=0):
		name = name.to_upper()
		selfHandlers[name] = handler
		if end_state:
			endStates.append(name)
	
	func set_start(name):
		startState = name.to_upper()
	
	func run(cargo):
		#  must call .set_start() before .run()
		var handler = selfHandlers[startState]
		#  at least one state must be an end_state
		
		while true:
			var newState

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass