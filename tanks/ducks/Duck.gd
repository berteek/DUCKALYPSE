extends Entity

class_name Duck

var is_dead = false

func die():
	set_frame(1)
	is_dead = true
