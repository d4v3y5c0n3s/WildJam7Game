extends Area

const IDENTITY = 0#  0 is the identity of rooms
const ITEM_Y_VALUE = {
	"ground_hall" : 7,
	"guest_room" : 7,
	"2nd_floor_hall" : 23,
	"bathroom" : 23,
	"2nd_floor_stairs" : 23,
	"3rd_floor_hall" : 39,
	"bedroom" : 39,
	"roof" : 55
}

var y_level
var people = []
var items = []

func _ready():
	y_level = ITEM_Y_VALUE[name]

#  THIS IS CALLED BY PEOPLE WHEN THEY ENTER SO THEY KNOW WHAT IS IN THE ROOM
func read_room():
	return [people, items]
