extends Navigation

# == CAMERA STUFF ==
onready var currentchar = $person
var hasCamera = false

var ppl # List of people.
var pIndex = 0 # Index in the people list.

onready var camera = $cambase/Camera



func getBegin(person_ref):
	print(get_closest_point(person_ref.get_translation()))
	return get_closest_point(person_ref.get_translation())
#func getEnd(go_here):
#	print(get_closest_point_to_segment((go_here), (go_here * 100)))
#	return get_closest_point_to_segment((go_here), (go_here * 100))

func pointGetEnd(go_here):
	print(get_closest_point(go_here))
	return get_closest_point(go_here)

func updatePath(p_begin, p_end):
	var p = get_simple_path(p_begin, p_end, true)
	var p_path = Array(p)
	p_path.invert()
	print(p_path)
	return p_path
	
# == CAMERA FUNCTIONS ==
	
func possess(): #Possess
	for person in ppl: # check every node in list
		person.possessed = false #un-possess them
		
	# For now it cycles through in one direction, this could probably change
	pIndex += 1 
	if pIndex > len(ppl):
		pIndex = 1
	if $people.has_node("person"+str(pIndex)): # if the person exists 
		currentchar = $people.get_child(pIndex-1) # set the current character
		currentchar.possessed = true # possess him/her
		currentchar.go_here(currentchar.translation) # stop him/her in their tracks
		hasCamera = true # update the camera every frame
	

func _ready():
	
	ppl = $people.get_children()
	

func _process(delta):
	if hasCamera: 
		camera.translation = Vector3(currentchar.translation.x, currentchar.translation.y + 5, 50)
		#print(camera.translation)
		
	if Input.is_action_just_pressed("ui_accept"): #possess with button
		possess()
		
