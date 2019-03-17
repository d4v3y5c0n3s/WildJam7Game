extends Position3D

const IDENTITY = 1#  1 is the identity of people

onready var navNodeRef = get_parent().get_parent()#  gets the navigation node

var state = 0
var perpetrator # helper variable for states which have perpetrators

# == STATE INDEX ==
#	0	|	Wander
#	1	|	Jealous
#	2	|	Angry
#	3	|	Fearful
#	4	|	Hostile
#	5	|	Thrilled
#	6	|	Dead

var speed = 6.0
var health = 20
var attack = 5
var possessed = false

var begin = Vector3()
var end = Vector3()
var path = Array()

#  deals with states
var current_action = 0
var completed_action = true

var b = true#  a general helper for the different states
var w = false#  another helper

var pick_up#  the item which is being picked up
var holding#  the item which is currently being held
var start_holding = false

#  deals with who is in the room
var visible_people = []
var visible_items = []

func go_here(pos):#  called to set up a path to follow
	# clears previous values
	begin = Vector3()
	end = Vector3()
	path = Array()

	begin = navNodeRef.getBegin(self)#  sets up begin
	end = navNodeRef.pointGetEnd(pos)#  sets up end
	path = navNodeRef.updatePath(begin, end)#  updates the path

	#  at this point, the path has been set up.
	#  now, call go_step to move the character
	#  by a step

func go_step(processDelta):
	#  actually moves the character by a step

	if path.size() > 1:
		var toWalk = processDelta * speed
		var toWatch = Vector3(0, 1, 0)

		while toWalk > 0 and path.size() >= 2:
			var pFrom = path[path.size() - 1]
			var pTo = path[path.size() - 2]

			toWatch = (pTo - pFrom).normalized()

			var d = pFrom.distance_to(pTo)
			if d <= toWalk:
				path.remove(path.size() - 1)
				toWalk -= d
			else:
				path[path.size() - 1] = pFrom.linear_interpolate(pTo, toWalk/d)
				toWalk = 0

		var atPos = path[path.size() - 1]
		var atDir = toWatch
		atDir.y = 0

		var t = Transform()

		t.origin = atPos
		t = t.looking_at(atPos + atDir, Vector3(0, 1, 0))#  this makes the character face where they are going
		set_transform(t)

		if path.size() < 2:
			path = []
			#  if this point is reached, our destination has been arrived at

		return false
	else:
		#  this means we are already at our destination
		return true

#  the following calls the above, but uses the Position3Ds
#  go_pos_z, go_neg_z, go_neg_x, go_pos_x to just move in
#  a direction;  could also be used for player control
func go_up(processDelta):
	print("going up")
	begin = navNodeRef.getBegin(self)
	end = navNodeRef.pointGetEnd(Vector3(begin.x, (begin.y + 1), (begin.z - 2)))
	path = navNodeRef.updatePath(begin, end)
	print(begin)
	print(end)
	print(path)

	go_step(processDelta)

func go_down(processDelta):
	print("going down")
	begin = navNodeRef.getBegin(self)
	end = navNodeRef.pointGetEnd(Vector3(begin.x, (begin.y + 1), (begin.z + 2)))
	path = navNodeRef.updatePath(begin, end)
	print(begin)
	print(end)
	print(path)

	go_step(processDelta)

func go_left(processDelta):
	print("going left")
	begin = navNodeRef.getBegin(self)
	end = navNodeRef.pointGetEnd(Vector3((begin.x + 2), (begin.y + 1), begin.z))
	path = navNodeRef.updatePath(begin, end)
	print(begin)
	print(end)
	print(path)

	go_step(processDelta)

func go_right(processDelta):
	print("going right")
	begin = navNodeRef.getBegin(self)
	end = navNodeRef.pointGetEnd(Vector3((begin.x - 2), begin.y, begin.z))
	path = navNodeRef.updatePath(begin, end)
	print(begin)
	print(end)
	print(path)

	go_step(processDelta)

func _process(delta):
	
	if not possessed:
		match state:
			0:#  wander state
				if completed_action:#  if there is no current action, randomly choose one
					current_action = randi() % 3 + 2#  chooses a random action
					completed_action = false
				else:
					match current_action:
						2:#  go to a random room
							if b:
								go_here(go_to_random_room())
								b = false
							if go_step(delta):
								completed_action = true
								b = true
						3:#  check the will
							pass
			1:#  jealous state
				pass
			2:#  angered state
				if completed_action:
					current_action = 0
					completed_action = false
				else:
					if b and !perpetrator.state == 6:
						print("going to"+str(perpetrator.translation))
						go_here(perpetrator.translation)
						b = false
					else:
						if perpetrator.state == 6:
							change_to_wander()
							completed_action = true
							b = true
					if go_step(delta):
						completed_action = true
						b = true
			3:#  fearful state
				pass
			4:#  hostile state
				pass
			5:#  thrilled state
				pass
			6:#  dead state
				pass
	else:
		if Input.is_action_pressed("ui_up"):#  up
			go_up(delta)
		elif Input.is_action_pressed("ui_down"):#  down
			go_down(delta)
		elif Input.is_action_pressed("ui_left"):#  left
			go_left(delta)
		elif Input.is_action_pressed("ui_right"):#  right
			go_right(delta)
			
		go_step(delta)

	#  hold on to any items the person has
	if start_holding:
		hold(holding)

#  THESE FUNCTIONS CHANGE THE CHARACTER STATE
func change_to_wander():
	state = 0
func change_to_jealous(target):
	perpetrator = target
	state = 1
func change_to_angered(target):
	perpetrator = target
	state = 2
func change_to_fearful():
	state = 3
func change_to_hostile(target):
	perpetrator = target
	state = 4
func change_to_thrilled():
	state = 5
func change_to_dead():
	state = 6
	hide()

func go_to_random_room():
	var room_id = randi() % 8 + 1
	print("-  room_id  -")
	print(room_id)
	match room_id:
		1:#  ground hall
			return Vector3(0, 7, 0)
		2:#  guest room
			return Vector3(38.808567, 7, -1.947572)
		3:#  2nd floor hall
			return Vector3(-29.28244, 23, 0)
		4:#  bathroom
			return Vector3(2.174207, 23, -1.872252)
		5:#  2nd floor stairs
			return Vector3(34.549664, 23, -1.41005)
		6:#  3rd floor hall
			return Vector3(16.354214, 39, -1.653817)
		7:#  bedroom
			return Vector3(-36.17395, 39, -2.304301)
		8:
			return Vector3(2.029072, 55, -3.927081)

#  functions related to holding items
func grab(the_item):
	the_item = holding
	start_holding = true
func hold(the_item):#  this is constantly called to keep hold of items
	the_item.translation = begin
func drop(the_item):
	pass
	
# functions related to interactions with things
func hit(damage):
	health -= damage
	print(health)
	if health <= 0:
		health = 0
		
		change_to_dead()

func _on_encounter_area_entered(area):
	if area.IDENTITY == 0:#  a room
		area.people.append(self)#  lets the room know that they have entered

		#  asks room what is inside
		visible_people = area.read_room()[0]
		visible_items = area.read_room()[1]
	elif area.IDENTITY == 1:#  a person
		var target = area.get_parent()
		match state:
			0:
				pass
				#target.call("change_to_angered")
			2:
				target.call("hit", self.attack)
			
	elif area.IDENTITY == 2:#
		pass
	elif area.IDENTITY == 3:#
		pass

func _on_encounter_area_exited(area):
	if area.IDENTITY == 0:#  a room
		area.people.erase(self)#  lets the room know that they have left
		#  clears visible items & people
		visible_items = []
		visible_people = []
	elif area.IDENTITY == 1:#  a person
		pass
	elif area.IDENTITY == 2:# an item
		pass
	elif area.IDENTITY == 3:# a door
		pass