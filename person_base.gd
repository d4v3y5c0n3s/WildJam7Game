extends Position3D

onready var navNodeRef = get_parent().get_parent()#  gets the navigation node

var state = 0
var speed = 4.0

var begin = Vector3()
var end = Vector3()
var path = Array()

func go_here(pos):#  called to set up a path to follow
	# clears previous values
	begin = Vector3()
	end = Vector3()
	path = Array()
	
	begin = navNodeRef.getBegin(self)#  sets up begin
	end = navNodeRef.getEnd(pos)#  sets up end
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
		self.set_transform(t)
		
		if path.size() < 2:
			path = []
			#  if this point is reached, our destination has been arrived at
		
	else:
		#  this means we are already at our destination
		pass

#  the following calls the above, but uses the Position3Ds 
#  go_pos_z, go_neg_z, go_neg_x, go_pos_x to just move in
#  a direction;  could also be used for player control
func go_up(processDelta):
	begin = Vector3()
	end = Vector3()
	path = Array()
	
	begin = navNodeRef.getBegin(self)
	end = navNodeRef.pointGetEnd(Vector3(self.translation.x, self.translation.y, (self.translation.z - 2)))
	path = navNodeRef.updatePath(begin, end)
	
	go_step(processDelta)

func go_down(processDelta):
	begin = Vector3()
	end = Vector3()
	path = Array()
	
	begin = navNodeRef.getBegin(self)
	end = navNodeRef.pointGetEnd(Vector3(self.translation.x, self.translation.y, (self.translation.z + 2)))
	path = navNodeRef.updatePath(begin, end)
	
	go_step(processDelta)

func go_left(processDelta):
	begin = Vector3()
	end = Vector3()
	path = Array()
	
	begin = navNodeRef.getBegin(self)
	end = navNodeRef.pointGetEnd(Vector3((self.translation.x + 2), self.translation.y, self.translation.z))
	path = navNodeRef.updatePath(begin, end)
	
	go_step(processDelta)

func go_right(processDelta):
	begin = Vector3()
	end = Vector3()
	path = Array()
	
	begin = navNodeRef.getBegin(self)
	end = navNodeRef.pointGetEnd(Vector3((self.translation.x - 2), self.translation.y, self.translation.z))
	path = navNodeRef.updatePath(begin, end)
	
	go_step(processDelta)

func _process(delta):
	
	#tests directional movement with player input
	if Input.is_action_pressed("ui_up"):#  up
		go_up(delta)
	elif Input.is_action_pressed("ui_down"):#  down
		go_down(delta)
	elif Input.is_action_pressed("ui_left"):#  left
		go_left(delta)
	elif Input.is_action_pressed("ui_right"):#  right
		go_right(delta)
	
	#deals with states
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