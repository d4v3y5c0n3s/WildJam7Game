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
	
	var handler#this allows handler to be used in run()
	
	func add_state(_name, handler, end_state=0):
		_name = _name.to_upper()
		handlers[_name] = handler
		if end_state:
			endStates.append(_name)
	
	func set_start(_name):
		startState = _name.to_upper()
	
	func run(cargo):
		if startState == null:
			print("must call .set_start() before .run()")
		if not endStates:
			print("there must be at least an end_state")
		while true:
			var newState = handler.front()
			cargo = handler.back()
			if newState.to_upper() in endStates:
				print("reached ", newState)
				break
			else:
				handler = handlers[newState.to_upper()]

var positive_adj = ["great", "super", "fun", "entertaining", "easy"]
var negative_adj = ["boring", "difficult", "ugly", "bad"]

func start_transitions(txt):
	splitted_txt = txt.split(null, 1)
	var word
	if splitted_txt.size() > 1:
		word = splitted_txt.front()
		txt = splitted_txt.back()
	else:
		word = txt
		txt = ""
	var newState
	if word == "Python":
		newState = "Python_state"
	else:
		newState = "error_state"
	return [newState, txt]
func gd_state_transitions(txt):
	splitted_txt = txt.split(null, 1)
	splitted_txt = txt.split(null, 1)
	var word
	if splitted_txt.size() > 1:
		word = splitted_txt.front()
		txt = splitted_txt.back()
	else:
		word = txt
		txt = ""
	var newState
	if word == "is":
		newState = "is_state"
	else:
		newState = "error_state"
	return [newState, txt]
func is_state_transitions(txt):
	splitted_txt = txt.split(null, 1)
	splitted_txt = txt.split(null, 1)
	var word
	if splitted_txt.size() > 1:
		word = splitted_txt.front()
		txt = splitted_txt.back()
	else:
		word = txt
		txt = ""
	var newState
	if word == "not":
		newState = "not_state"
	elif word in positive_adjectives:
		newState = "pos_state"
	elif word in negative_adjectives:
		newState = "neg_state"
	else:
		newState = "error_state"
	return [newState, txt]
func not_state_transitions(txt):
	splitted_txt = txt.split(null, 1)
	splitted_txt = txt.split(null, 1)
	var word
	if splitted_txt.size() > 1:
		word = splitted_txt.front()
		txt = splitted_txt.back()
	else:
		word = txt
		txt = ""
	var newState
	if word in positive_adjectives:
		newState = "neg_state"
	elif word in negative_adjectives:
		newState = "pos_state"
	else:
		newState = "error_state"
	return [newState, txt]
func neg_state(txt):
	print("Hallo")
	return ["neg_state", ""]

###

func _ready():
	var m = StateMachine()
	m.add_state("Start", start_transitions())
	m.add_state("Python_state", python_state_transitions())
	m.add_state("is_state", is_state_transitions())
	m.add_state("not_state", not_state_transitions())
	m.add_state("neg_state", null, 1)
	m.add_state("pos_state", null, 1)
	m.add_state("error_state", null, 1)
	m.set_start("Start")
	m.run("Python is great")
	m.run("Python is difficult")
	m.run("Perl is ugly")