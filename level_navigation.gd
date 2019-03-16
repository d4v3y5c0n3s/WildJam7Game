extends Navigation

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