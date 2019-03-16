extends Area

const IDENTITY = 2
const ITEM_TYPE = {
	"knife_item" : 0
}

var claimed = false

var type#  an int value for what type of item it is
#  0 = weapon, 1 = key

var respawn_point = Vector3()

func _ready():
	respawn_point = self.translation#  sets the respawn point for the item
	
	

#  deals with picking up and dropping the item
func pick_up():
	pass
func drop():
	pass


func _on_knife_item_area_entered(area):
	if area.IDENTITY == 0 and not claimed:
		#  let the room know the item is there
		area.items.append(self)

func _on_knife_item_area_exited(area):
	if area.IDENTITY == 0:
		area.items.erase(self)
