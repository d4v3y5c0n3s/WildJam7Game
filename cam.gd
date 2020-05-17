extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var currentchar = $person
var hasCamera = false

onready var camera = $Camera


func updateCam():
	if hasCamera:
		pass
		
	camera = Camera.new()
	camera.current = true
	hasCamera = true
	
func possess():
	var ppl = 0

func _ready():
	self.add_child(camera)
	
	hasCamera = true

func _process(delta):
	if hasCamera:
		camera.translation = Vector3(currentchar.translation.x, currentchar.translation.y + 5, 50)
		print(camera.translation)
		
