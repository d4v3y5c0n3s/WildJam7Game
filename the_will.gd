extends Area

const IDENTITY = 2
var people
var inheritance
var guy_who_gets_money

func _ready():
	people = get_parent().get_node("people")
	inheritance = randi() % people.get_child_count()
	guy_who_gets_money = people.get_children()[inheritance]
